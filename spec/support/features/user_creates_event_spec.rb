require 'rails_helper'
require 'support/features'

feature "Registered user creates a new event" do 

  scenario 'with valid params' do
    sign_up_with 'tester2@example.com', 'password'
    create_test_park
    create_new_event_with "Sample Event", "Arbutus Village Park", "15-12-2017", "11 AM", "15", 45, "Sample event for testing" 
    expect(page).to have_content("Sample Event has been successfully created")
  end

  scenario 'with invalid params' do
    sign_up_with 'tester2@example.com', 'password'
    create_test_park
    create_new_event_with "Sample Event", "Arbutus Village Park", "", "11 AM", "15", 45, "Sample event for testing" 
    expect(page).to have_content("Date can't be blank")
  end

end