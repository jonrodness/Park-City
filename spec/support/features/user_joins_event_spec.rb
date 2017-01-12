require 'rails_helper'
require 'support/features'

feature "Registered user join another users event" do 

  scenario 'user 1 creates an event and user 2 joins the event' do
    # user 1 creates an event
    sample_user_creates_sample_event("Sample Event")
    # user 2 joins the event'
    sign_up_with 'alan@example.com', 'password'
    join_event "Sample Event"
    expect(page).to have_content("You have successfully joined Sample Event")

    end
end