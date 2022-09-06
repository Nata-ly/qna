require 'rails_helper'

RSpec.describe CommentsChannel, type: :channel do
  it "subscribes without streams" do
    subscribe

    expect(subscription).to be_confirmed
  end
end
