require "rails_helper"

RSpec.describe NewAnswerNotificationMailer, type: :mailer do
  describe "notification" do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let!(:subscription) { create(:subscription, user: user, question: question) }
    let(:answer) { create(:answer, question: question, user: user) }
    let(:mail) { NewAnswerNotificationMailer.notification(user, answer) }

    it "renders the headers" do
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders answer body" do
      expect(mail.body.encoded).to match(answer.body)
    end
  end
end
