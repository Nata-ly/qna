require 'rails_helper'

feature 'User can write an answer to the question', %q{
  To help with a decision
  As an authenticated user
  I can create an answer to a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'answers the question' do
      fill_in 'Body', with: 'Test answer'
      click_on 'Reply'

      expect(page).to have_content question.title
      expect(page).to have_content 'Test answer'
    end

    scenario 'answers the question with errors' do
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end
  end
  scenario 'Unauthenticated user answers the question' do
    visit question_path(question)

    fill_in 'Body', with: 'Test answer'
    click_on 'Reply'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
