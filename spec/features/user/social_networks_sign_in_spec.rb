require 'rails_helper'

feature 'Social networks sign in', %q{
  In order to sign in with social network
  As an quest
  I want to be able to sign in via social nwtwork
} do

  scenario 'github' do
    OmniAuth.config.add_mock(:github, { uid: '1234', info: { email: 'github@t.er'} })
    visit new_user_session_path
    click_on 'Sign in with GitHub'

    expect(page).to have_content 'Successfully authenticated from github account.'
    expect(current_path).to eq root_path
  end

  scenario 'vkontakte' do

    OmniAuth.config.add_mock(:vkontakte, { uid: '1234' })
    visit new_user_session_path
    click_on 'Sign in with Vkontakte'
    expect(page).to have_content 'Please confirm your email address.'

    fill_in 'Email', with: 'test@ema.il'

    click_on 'Continue'
    open_email('test@ema.il')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'

    visit new_user_session_path
    click_on 'Sign in with Vkontakte'

    expect(page).to have_content 'Successfully authenticated from vkontakte account.'
    expect(current_path).to eq root_path
  end
end
