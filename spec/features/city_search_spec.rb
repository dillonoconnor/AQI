require 'rails_helper'

RSpec.feature "stationSearches", type: :feature do
  scenario "User searches for a station" do
    visit root_path
    fill_in "station[stationname]", with: "Tianjin"
    click_on "Search"
    expect(page).to have_selector("li")
  end
end
