require 'rails_helper'

feature 'User can delete their answer to the question', %q{
  To fix a errors
  As an authenticated user
  I can delete an answer to a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:another_answer) { create(:answer, user: create(:user), question: question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'deletes their answer' do
      click_on 'Delete answer'

      expect(page).to have_content 'Your answer successfully destroy.'
      expect(page).to have_no_content answer.body
    end

    scenario "does not see a link to delete another user's answer" do
      expect(page).to have_no_link('Delete answer', href: answer_path(another_answer))
    end
  end
  scenario 'Unauthenticated user deletes answer' do
    visit question_path(question)
    expect(page).to have_no_link('Delete answer', href: answer_path(answer))
  end
end
