class City < ApplicationRecord

  has_many :measurements
  validates :name, presence: true, uniqueness: true
  before_create :set_slug

  def self.fetch_aqi(city)
    response = HTTP.get("https://api.waqi.info/feed/#{city}/?token=#{ENV["AQI_TOKEN"]}")
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
      self.slug = name.parameterize
    end

end
