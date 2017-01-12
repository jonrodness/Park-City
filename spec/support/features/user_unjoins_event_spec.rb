require 'rails_helper'
require 'support/features'



feature "Registered user unjoins a previously joined event users event" do 

  scenario 'user 2 unjoins previously joined event' do
# user 1 creates an event
    sample_user_creates_sample_event("Sample Event")
    # user 2 joins the event'
    sign_up_with 'alan@example.com', 'password'
    join_event "Sample Event"
    expect(page).to have_content("You have successfully joined Sample Event")    
    visit events_path
    unjoin_event "Sample Event"
    expect(page).to have_content("You have successfully unjoined Sample Event")
  end

end