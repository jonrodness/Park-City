require 'rails_helper'
require 'support/features'



feature "Any user can view a list of all events" do

  scenario "Any visitor is able to see a list of all events" do

    sample_user_creates_sample_event("Test Event")
    sign_in_with 'tester2@example.com', 'password'
    create_sample_event("Hello World")
    create_sample_event("Hola Chica")
    create_sample_event("Hello World2")
    create_sample_event("Hola Chica2")

    sign_out
    visit events_path

    expect(page).to have_content("Hello World")
    expect(page).to have_content("Hola Chica")
    expect(page).to have_content("Hello World2")
    expect(page).to have_content("Hola Chica2")
  end

end