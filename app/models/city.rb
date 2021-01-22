class City < ApplicationRecord
  def self.fetch_aqi(city)
    response = HTTP.get("https://api.waqi.info/feed/#{city}/?token=#{ENV["AQI_TOKEN"]}")
    JSON.parse(response)["data"]
  end

  def recent?
    created_at >= 1.day.ago
  end

end
