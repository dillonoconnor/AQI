require 'rails_helper'

RSpec.describe Station, type: :model do

  describe "#retrieve_attributes" do
    it "returns a station object" do
      station = Station.retrieve_attributes("Tianjin")
      expect(station).to be_a(Struct)
      expect(station.city_name).to eq("Tianjin (天津)")
    end
  end

  describe ".recent?" do
    it "returns false for database entries older than 1 day" do
      state = State.create!(name: "teststate")
      station = state.stations.create!(station_name:"teststation", created_at: 2.days.ago, state_id: 1)
      expect(station.recent?).not_to be_truthy
    end
    it "returns true for database entries >= 1 day old" do
      state = State.create!(name: "teststate")
      station = state.stations.create!(station_name:"teststation", created_at: 23.hours.ago)
      expect(station.recent?).to be_truthy
      station.created_at = 1.hour.ago
      expect(station.recent?).to be_truthy
    end
  end

  describe ".needs_refresh?" do
    it "returns true if the entry is old or has no measurements" do
      state = State.create!(name: "teststate")
      station = state.stations.create!(station_name: "test_station", created_at: 2.days.ago, state_id: 1)
      expect(station.needs_refresh?).to be_truthy
      station.measurements.create!(pm25_avg: 10)
      expect(station.needs_refresh?).to be_truthy

    end
    it "returns false for newer entries with measurements" do
      state = State.create!(name: "teststate")
      station = state.stations.create!(station_name: "test_station", created_at: 23.hours.ago, state_id: 1)
      station.measurements.create!(pm25_avg: 10)
      expect(station.needs_refresh?).to be_falsey
    end

  end
end
