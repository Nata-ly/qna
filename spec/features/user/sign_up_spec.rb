require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions
  As an unregistered user
  I'd like to be able to sign up
} do

  background { visit new_user_registration_path }

  scenario 'Unregistered user tries to sign up', js: true do
    fill_in 'Email', with: 'Email@test.com'
    fill_in 'Password', with: 'Password'
    fill_in 'Password confirmation', with: 'Password'

    click_on 'Sign up'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end
  scenario 'Unregistered user tries to sign up with errors' do
    click_on 'Sign up'

    expect(page).to have_content "Email can't be blank"
  end
end
