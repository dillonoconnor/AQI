# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

STATES = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
          "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", 
          "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
          "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", 
          "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", 
          "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", 
          "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming", "Washington D.C."]

STATES.each do |s|
  State.create!(name: s)
end

State_Stations = Struct.new(:state, :stations)

doc = Nokogiri::HTML(URI.open("https://aqicn.org/city/all/"))

i = 644
while i <= 1815
  station_state = doc.css("div.section-content a")[i].text.split(", ")
  unless (station_state & STATES).empty?
    state_intersect = station_state & STATES
    state_intersect = state_intersect[1].split if state_intersect.size > 1
    state = State.find_by(name: state_intersect)
    if state_intersect.first == station_state.first
      station = station_state.first
    else
      station = (station_state - state_intersect).join(", ")
    end
    state.stations.create!(station_name: station)
  end
  i += 1
end

#TODO - find indexes of stations with no states