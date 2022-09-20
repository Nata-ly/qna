require 'rails_helper'

RSpec.describe AnswersChannel, type: :channel do
  it "subscribes without streams" do
    subscribe room: 1

    expect(subscription).to be_confirmed
  end
end
