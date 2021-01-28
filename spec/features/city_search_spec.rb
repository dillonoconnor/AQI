require 'rails_helper'

RSpec.feature "CitySearches", type: :feature do
  scenario "User searches for a city" do
    visit root_path
    fill_in "city[cityname]", with: "Tianjin"
    click_on "Search"
    expect(page).to have_selector("li")
  end
end
