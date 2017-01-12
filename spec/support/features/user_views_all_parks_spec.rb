require 'rails_helper'
require 'support/features'


feature "User can view a list of all parks" do

  scenario "if user is registered" do
    create_test_park
    sign_up_with 'alan@example.com', 'password'
    sign_out
    sign_in_with 'alan@example.com', 'password'
    visit parks_path
    expect(page).to have_content("Arbutus Village Park")
    expect(page).to have_content("Creekway Park")
  end

  scenario "if user is uregistered" do
    create_test_park
    visit parks_path
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

end
