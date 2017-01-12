module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Create an account'
    end

    def sign_in_with(email, password)
      visit "/users/sign_in"
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end

    def sign_out
      click_link 'Sign Out'
    end

    def create_new_event_with(title, park, date, time1, time2, spots, description)
      visit new_event_path
      fill_in 'Title', with: title
      # find(:select, "event_park_id").first(:option, 'Aberdeen Park').select_option
      select park, from: "Park", visible: false
      fill_in 'Date', with: date
      fill_in 'Spots', with: spots
      fill_in 'Description', with: description
      click_button 'Create Event'
    end

    def join_event(title)
      click_link title
      click_link "Join"
    end

    def unjoin_event(title)
      click_link title
      click_link "Unjoin"
    end

    def sample_user_creates_sample_event(title)
      sign_up_with 'tester2@example.com', 'password'
      create_test_park
      create_new_event_with title, "Arbutus Village Park", "15-12-2017", "11 AM", "15", 45, "Sample event for testing" 
      expect(page).to have_content("#{title} has been successfully created")
      sign_out
    end

    def create_sample_event(title)
      create_new_event_with title, "Arbutus Village Park", "15-12-2017", "11 AM", "15", 45, "Sample event for testing" 
      expect(page).to have_content("#{title} has been successfully created")
    end

    def create_test_park
      Park.create!(name: "Arbutus Village Park", official: nil, streetNumber: 4202, streetName: "Valley Drive", ewStreet: "King Edward Avenue", washroom: "", nsstreet: "Valley Drive", googleMapDest: "49.249783,-123.155250", hectare: "1.41", park_id: nil, created_at: "2015-04-03 01:09:03", updated_at: "2015-04-03 01:09:03")
      Park.create!(id: 246, name: "Creekway Park", official: nil, streetNumber: 2901, streetName: "E Hastings Street", ewStreet: "McGill Street", washroom: "", nsstreet: "", googleMapDest: "49.288336,-123.036982", hectare: "8", park_id: nil, created_at: "2015-04-03 01:11:38", updated_at: "2015-04-03 01:11:38")
    end
  end
end