require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user can not edit answer', js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    scenario 'edits his answer' do
      sign_in user

      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'text_area'
      end
    end

    scenario 'edits his answer with errors' do
      sign_in user

      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        fill_in 'Your answer', with: ''
        click_on 'Save'
      end
      expect(page).to have_content "Body can't be blank"
      expect(page).to have_content answer.body
    end

    scenario "tries to edit other user's answer" do
      sign_in create(:user)
      visit question_path(question)
      within '.answers' do
        expect(page).to have_no_link('Edit')
      end
    end
  end
end
