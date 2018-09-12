require 'rails_helper'

describe 'visitor' do
  context 'visits /' do
    it 'should see the most dangerous days for given date range' do
      # As a guest user
      visit '/'
      # When I visit "/"
      fill_in 'start_date', with: "2018-09-08"
      # And I enter "2018-01-01" into the start date

      fill_in 'end_date', with: "2018-09-15"
      # And I enter "2018-01-07" into the end date
      click_on "Determine Most Dangerous Day"
      # And I click "Determine Most Dangerous Day"
      expect(current_path).to eq('/most_dangerous_day')
      # Then I should be on "/most_dangerous_day"
      expect(page).to have_content("Most Dangerous Day")
      # And I should see a heading for "Most Dangerous Day"
      expect(page).to have_content("September 8, 2018 - September 15, 2018")
      # And I should see "January 1, 2018 - January 7, 2018"
      expect(page).to have_content("Most dangerous day in that range: September 11, 2018")
      # And I should see a heading for the most dangerous day in that range "January 1, 2018"
      expect(page).to have_css(".asteroid", count: 9)
      # And I should see 3 asteroids in that list

      within(".asteroids") do
        expect(page).to have_content("Name: 518640 (2008 KZ5)")
        expect(page).to have_content("NEO Reference ID: 2518640")
      # And I should see "Name: (2014 KT76)"
      # And I should see "NEO Reference ID: 3672906"
        expect(page).to have_content("Name: (2010 CO1)")
        expect(page).to have_content("NEO Reference ID: 3507718")
      # And I should see "Name: (2001 LD)"
      # And I should see "NEO Reference ID: 3078262"
      end
    end
  end
end
