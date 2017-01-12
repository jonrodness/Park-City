require 'rails_helper'
require 'support/features'


feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'tester2@example.com', 'password'
    expect(page).to have_content('You have signed up successfully')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'
    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''
    expect(page).to have_content('Sign in')
  end

end


















