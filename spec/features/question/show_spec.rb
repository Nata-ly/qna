require 'rails_helper'

feature 'User can view the question and the list of answers to it', %q{
  To find out the answers
  As an user
  I want to view a question and a list of answers to it
} do
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  scenario 'User views question and the list of answers to it' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each { |answer| expect(page).to have_content answer.body }
  end
end
