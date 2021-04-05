class StationsController < ApplicationController

  def index
    @station = Station.new
    @states = State.all
  end

  def create
    station_name = set_station_name
    station = Station.active_listing(station_name)
    station_attributes = Station.retrieve_attributes(station_name)

    if station_attributes == "Unknown station"
      return redirect_to root_url, alert: "Error: Unknown Station"
    elsif station_attributes == "Not reporting"
      return redirect_to root_url, alert: "This station doesn't seem to be reporting"
    end

    if station && station.needs_refresh?
      station.update!(
        aqi: station_attributes.aqi,
        aqi_date: station_attributes.time_s
      )
      station_attributes.forecast_daily_pm25.each do |sample|
        next if station.has_existing_measurement(sample)
        station.measurements.create!(
          measurement_date: sample["day"],
          pm25_avg: sample["avg"],
          pm25_min: sample["min"],
          pm25_max: sample["max"]
        )
      end
      redirect_to station
    else
      redirect_to station
    end
  end

  def show
    @station = Station.find_by(slug: params[:id])
    @forecasts = @station.measurements
  end

  private

    def set_station_name
      if params[:station_name]
        params[:station_name]
      else
        params[:station][:station_name]
      end
    end
end
