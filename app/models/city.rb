class City < ApplicationRecord

  has_many :measurements

  def self.fetch_aqi(city)
    response = HTTP.get("https://api.waqi.info/feed/#{city}/?token=#{ENV["AQI_TOKEN"]}")
    JSON.parse(response)["data"]
  end

  def recent?
    created_at >= 1.day.ago
  end

  def self.pm25_datapoints(city)
    where("name LIKE ?", city.name).select("pm25_forecast1", "pm25_forecast1_date", 
          "pm25_forecast2", "pm25_forecast2_date", "pm25_forecast3", "pm25_forecast3_date", 
          "pm25_forecast4", "pm25_forecast4_date", "pm25_forecast5", "pm25_forecast5_date", 
          "pm25_forecast6", "pm25_forecast6_date", "pm25_forecast7", "pm25_forecast7_date", 
          "pm25_forecast8", "pm25_forecast8_date")[0]
  end

end
