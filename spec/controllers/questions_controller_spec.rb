require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'assigns new link for answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end

    it 'assigns a new Link to @question.link' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it '' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end


      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    before { get :show, params: { id: question } }

    context 'with valid attributes' do
      it 'change question attributes' do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :js
        question.reload
        expect(question.body).to eq 'new body'
      end

      it 'render update view' do
        patch :update, params: { id: question, question: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change question attributes' do
        expect do
          patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
        end.to_not change(question, :body)
      end

      it 'render update view' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy_file' do
    before do
      question.files.attach(
        io: File.open(Rails.root.join('spec', 'rails_helper.rb')),
        filename: 'rails_helper.rb'
      )
    end
    before { login(user) }

    it 'delete question file' do
      expect do
        delete :destroy_file, params: { id: question, file_id: question.files.first.id }, format: :js
      end.to change(question.files, :count).by(-1)
    end

    it 'render destroy_file view' do
      delete :destroy_file, params: { id: question, file_id: question.files.first.id }, format: :js
      expect(response).to render_template :destroy_file
    end
  end

  describe 'DELETE #destroy_link' do
    before do
      question.links.create(name: 'test', url: 'http://google.com')
    end
    before { login(user) }

    it 'delete question link' do
      expect do
        delete :destroy_link, params: { id: question, link: question.links.first.id }, format: :js
      end.to change(question.links, :count).by(-1)
    end

    it 'render destroy link view' do
      delete :destroy_link, params: { id: question, link: question.links.first.id }, format: :js
      expect(response).to render_template :destroy_link
    end
  end

end
