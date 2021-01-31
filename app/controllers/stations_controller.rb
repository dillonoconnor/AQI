class StationsController < ApplicationController

  def index
    @station = Station.new
    if params[:station]
      @station_matches = params[:station]
    end
    @stations = Station.all
    @states = State.all
  end

  def create
    station_name = params[:station][:station_name]
    station = Station.where("station_name LIKE ?", "%#{station_name}%").first
    if station && station.recent?
      redirect_to station
    else
      if station
        station.destroy
      end
      if fetch(station_name) == "Unknown station"
        redirect_to root_url, alert: "Error: Unknown Station"
      else
        new_station = Station.create!(
          station_name: station_struct.name,
          aqi: station_struct.aqi,
          aqi_date: station_struct.aqi_time
        )
        station_struct.pm25_forecast.each do |sample|
          new_station.measurements.create!(
            measurement_date: sample["day"],
            pm25_avg: sample["avg"],
            pm25_min: sample["min"],
            pm25_max: sample["max"]
          )
        end
        redirect_to new_station
      end
    end
  end

  def show
    @station = Station.find_by(slug: params[:id])
    @forecasts = @station.measurements
  end

  private

    def fetch(station_name)
      station_data = Station.fetch_aqi(station_name)
      if station_data == "Unknown station"
        return "Unknown station"
      end
      stationAQI = Struct.new(:name, :aqi, :aqi_time, :pm25_forecast)
      @station_struct = stationAQI.new(station_data["city"]["name"], station_data["aqi"], 
                     station_data["time"]["s"], station_data["forecast"]["daily"]["pm25"])
    end

    def station_struct
      @station_struct
    end
end
