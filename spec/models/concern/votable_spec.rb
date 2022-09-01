require 'rails_helper'

shared_examples_for 'votable' do
  it { should have_many(:votes).dependent(:destroy) }
  let(:model) { described_class }

  it 'vote value' do
    expect(model.new.vote_value).to match(0)
  end
end
