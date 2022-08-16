require 'rails_helper'

feature 'Authenticated user can sign out', %q{
  To end the session
  As an authenticated user
  I want to go out
} do

  given(:user) { create(:user) }

  background { sign_in(user) }

  scenario 'Authenticated user wants to log out' do
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
