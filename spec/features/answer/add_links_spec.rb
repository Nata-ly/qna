require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info my answer
  As an question's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: create(:user)) }
  given!(:answer) { create(:answer, question: question, user: user) }


  given(:gist_url) { 'https://gist.github.com/Nata-ly/60e4708bbf5f82412ba5334ded3fd8ea' }


  scenario 'User adds link when asks answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Test answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Reply'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end

  scenario 'User add link when edit answer', js: true do

    sign_in(user)
    visit question_path(question)
    click_on 'Edit'

    within '.answers' do
      click_link 'add link'

      fill_in 'Your answer', with: 'edited answer'
      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: gist_url
      click_on 'Save'
    end

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end
end
