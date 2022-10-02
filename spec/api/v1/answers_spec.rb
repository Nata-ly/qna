require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) {{"CONTENT_TYPE" => "application/json",
                  "ACCEPT" => 'application/json'}}

  describe 'GET /api/v1/question/:question_id/answers' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let!(:answers) { create_list(:answer, 2, question: question, user: user) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) {create(:access_token)}
      let(:answer_response) { json['answers'].first }

      before {get api_path, params: {access_token: access_token.token}, headers: headers}

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns list of questions' do
        expect(json['answers'].size).to eq answers.size
      end

      it_behaves_like 'Returns list' do
        let(:resource_response) { json['answers'] }
        let(:resource) { answers }
      end

      it_behaves_like 'Returns public fields' do
        let(:attrs) { %w[id body user_id created_at updated_at] }
        let(:resource_response) { json['answers'].first }
        let(:resource) { answers.first }
      end
    end
  end
end
