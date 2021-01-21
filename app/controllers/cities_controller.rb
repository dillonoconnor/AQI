class CitiesController < ApplicationController
  def index
    @city = City.new
  end

  def create
    city = params[:city][:cityname]
    fetch(city)
    new_city = City.new(
      name: city_struct.name,
      aqi: city_struct.aqi,
      aqi_date: city_struct.aqi_time
    )
    city_struct.pm25_forecast.each_with_index do |day, index|
      new_city["pm25_forecast#{index + 1}"] = day["avg"]
      new_city["pm25_forecast#{index + 1}_date"] = day["day"]
    end
    if new_city.save
      redirect_to new_city
    else
      render :index
    end
  end

  def show
    @city = City.find(params[:id])
  end

  private

    def fetch(city)
      city_data = City.fetch_aqi(city)
      cityAQI = Struct.new(:name, :aqi, :aqi_time, :pm25_forecast)
      @city_struct = cityAQI.new(city_data["city"]["name"], city_data["aqi"], 
                     city_data["time"]["s"], city_data["forecast"]["daily"]["pm25"])
    end

    def city_struct
      @city_struct
    end
end
