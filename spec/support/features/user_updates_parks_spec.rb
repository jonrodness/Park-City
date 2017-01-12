require 'rails_helper'
require 'support/features'



feature "Update parks button updates the list of parks" do

  scenario "user clicks on update parks" do
    sign_up_with 'alan@example.com', 'password'
    visit events_path
    click_link "Update Parks"
    visit parks_path
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

end