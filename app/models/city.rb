class City < ApplicationRecord
  def self.fetch_aqi(city)
    response = HTTP.get("https://api.waqi.info/feed/#{city}/?token=#{ENV["AQI_TOKEN"]}")
    JSON.parse(response)["data"]
  end
end
