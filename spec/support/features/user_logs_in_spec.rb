require 'rails_helper'
require 'support/features'

feature 'Registered User logs in' do

  scenario 'with valid email and password do' do
    sign_up_with 'tester2@example.com', 'password'
    sign_out
    sign_in_with 'tester2@example.com', 'password'
    expect(page).to have_content("Signed in successfully")
  end

  scenario 'with invalid email and password do' do
    sign_up_with 'tester2@example.com', 'password'
    sign_out
    sign_in_with 'tester2@example.com', 'passasdasword'
    expect(page).to have_content("Invalid email or password")
  end

end