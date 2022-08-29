require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    let(:user) { create(:user) }
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'render template create' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end
    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }, format: :js }.to_not change(Answer, :count)
      end


      it 're-renders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question) }

    context 'with valid attributes' do
      it 'change answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'PATCH #mark_as_best' do
    let(:user) { create(:user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    it 'change best answer' do
      post :mark_as_best, params: { id: answer }, format: :js
      question.reload
      expect(question.best_answer).to eq answer
    end

    it 'render mark_as_best view' do
      post :mark_as_best, params: { id: answer }, format: :js
      expect(response).to render_template :mark_as_best
    end
  end

  describe 'DELETE #destroy_file' do
    let(:user) { create(:user) }
    let!(:answer) { create(:answer, question: question, user: user) }
    before do
      answer.files.attach(
        io: File.open(Rails.root.join('spec', 'rails_helper.rb')),
        filename: 'rails_helper.rb'
      )
    end
    before { login(user) }

    it 'delete answer file' do
      expect do
        delete :destroy_file, params: { id: answer, file_id: answer.files.first.id }, format: :js
      end.to change(answer.files, :count).by(-1)
    end

    it 'render destroy_file view' do
      delete :destroy_file, params: { id: answer, file_id: answer.files.first.id }, format: :js
      expect(response).to render_template :destroy_file
    end
  end


  describe 'DELETE #destroy_link' do
    let(:user) { create(:user) }
    let!(:answer) { create(:answer, question: question, user: user) }
    before do
      answer.links.create(name: 'test', url: 'http://google.com')
    end
    before { login(user) }

    it 'delete answer link' do
      expect do
        delete :destroy_link, params: { id: answer, link: answer.links.first.id }, format: :js
      end.to change(answer.links, :count).by(-1)
    end

    it 'render destroy link view' do
      delete :destroy_link, params: { id: answer, link: answer.links.first.id }, format: :js
      expect(response).to render_template :destroy_link
    end
  end
end
