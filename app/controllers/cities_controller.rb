class CitiesController < ApplicationController
  def index
    @city = City.new
  end

  def create
    city_name = params[:city][:cityname]
    city = City.where("name LIKE ?", "%#{city_name}%").first
    if city && city.recent?
      redirect_to city
    else
      fetch(city_name)
      new_city = City.create!(
        name: city_struct.name,
        aqi: city_struct.aqi,
        aqi_date: city_struct.aqi_time
      )
      city_struct.pm25_forecast.each do |sample|
        new_city.measurements.create!(
          measurement_date: sample["day"],
          pm25_avg: sample["avg"],
          pm25_min: sample["min"],
          pm25_max: sample["max"]
        )
      end
      redirect_to new_city
    end
  end

  def show
    @city = City.find(params[:id])
    @forecasts = @city.measurements
  end

  private

    def fetch(city_name)
      city_data = City.fetch_aqi(city_name)
      cityAQI = Struct.new(:name, :aqi, :aqi_time, :pm25_forecast)
      @city_struct = cityAQI.new(city_data["city"]["name"], city_data["aqi"], 
                     city_data["time"]["s"], city_data["forecast"]["daily"]["pm25"])
    end

    def city_struct
      @city_struct
    end
end
