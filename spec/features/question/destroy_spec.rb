require 'rails_helper'

feature 'User can delete their question', %q{
  To fix a errors
  As an authenticated user
  I can delete a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'deletes their question' do
      click_on 'Delete question'

      expect(page).to have_content 'Your question successfully destroy.'
    end

    scenario "does not see a link to delete another user's question" do
      expect(page).to have_no_link('Delete answer', href: question_path(question))
    end
  end
  scenario 'Unauthenticated user deletes question' do
    visit question_path(question)
    expect(page).to have_no_link('Delete answer', href: question_path(question))
  end
end
