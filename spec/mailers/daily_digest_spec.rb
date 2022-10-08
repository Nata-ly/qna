require "rails_helper"

RSpec.describe DailyDigestMailer, type: :mailer do
  describe "digest" do
    let!(:user) { create(:user) }
    let(:mail) { DailyDigestMailer.digest(user) }
    let(:question_yesterday) { create_list(:question, 2, :created_at_yesterday) }
    let(:question_last) { create_list(:question, 2, :created_at_last) }

    it "renders the headers" do
      expect(mail.subject).to eq("Digest")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders only yesterday questions" do
      question_yesterday.each do |question|
        expect(mail.body.encoded).to match(question.title)
      end

      question_last.each do |question|
        expect(mail.body.encoded).to_not match(question.title)
      end
    end
  end

end
