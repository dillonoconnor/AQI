class Station < ApplicationRecord

  belongs_to :state
  has_many :measurements
  before_create :set_slug

  def self.retrieve_attributes(station)

    parsed_aqi_data = Struct.new(:idx, :aqi, :time, :time_s, :time_tz, :city, :city_name, :city_geo, :city_url,
                              :attributions, :iaqi, :iaqi_pm25, :iaqi_pm25_v, :forecast, :forecast_daily,
                              :forecast_daily_pm25, :forecast_daily_pmp10, :forecast_daily_o3,
                              :forecast_daily_uvi)

    before_response = HTTP.get("http://api.waqi.info/search/?token=#{ENV["AQI_TOKEN"]}&keyword=#{station}")
    station_uid = JSON.parse(before_response)["data"][0]["uid"]

    response = HTTP.get("https://api.waqi.info/feed/@#{station_uid}/?token=#{ENV["AQI_TOKEN"]}")
    json = JSON.parse(response)["data"]

    if json == "Unknown station"
      "Unknown station"
    else
      parsed_aqi_data.new(
        json["idx"],
        json["aqi"],
        json["time"],
        json["time"]["s"],
        json["time"]["tz"],
        json["city"],
        json["city"]["name"],
        json["city"]["geo"],
        json["city"]["url"],
        json["attributions"],
        json["iaqi"],
        json["iaqi"]["pm25"],
        json["iaqi"]["pm25"]["v"],
        json["forecast"],
        json["forecast"]["daily"],
        json["forecast"]["daily"]["pm25"],
        json["forecast"]["daily"]["pmp10"],
        json["forecast"]["daily"]["o3"],
        json["forecast"]["daily"]["uvi"]
      )
    end
  end

  def recent?
    created_at >= 1.day.ago
  end

  def self.active_listing(station_name)
    Station.where("station_name LIKE ?", "%#{station_name}%").first
  end

  def needs_refresh?
    recent? && measurements.any? ? false : true
  end

  def has_existing_measurement(sample)
    measurements.pluck(:measurement_date).include?(sample["day"].to_date)
  end

  def to_param
    slug
  end

  private

    def set_slug
      self.slug = station_name.parameterize
    end

end