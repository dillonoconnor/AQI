class Station < ApplicationRecord

  belongs_to :state
  has_many :measurements
  validates :station_name, presence: true
  before_create :set_slug

  def self.fetch_aqi(station)
    response = HTTP.get("https://api.waqi.info/feed/#{station}/?token=#{ENV["AQI_TOKEN"]}")
    JSON.parse(response)["data"]
  end

  def recent?
    created_at >= 1.day.ago
  end

  def to_param
    slug
  end

  private

    def set_slug
      self.slug = station_name.parameterize
    end

end