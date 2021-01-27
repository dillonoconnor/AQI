require 'rails_helper'

RSpec.describe City, type: :model do

  describe "#fetch_aqi" do
    it "returns a city object" do
      c = City.fetch_aqi("Tianjin")
      expect(c).to be_a(Hash)
      expect(c["city"]["name"]).to eq("Tianjin (天津)")
    end
  end

  describe ".recent?" do
    it "returns false for database entries older than 1 day" do
      c = City.create!(name:"testcity", created_at: 2.days.ago)
      expect(c.recent?).not_to be_truthy
    end
    it "returns true for database entries >= 1 day old" do
      c = City.create!(name:"testcity", created_at: 23.hours.ago + 59.minutes)
      expect(c.recent?).to be_truthy
      c["created_at"] = 1.hour.ago
      expect(c.recent?).to be_truthy
    end
  end
end
