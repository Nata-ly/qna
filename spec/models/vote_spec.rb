require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:votable) }

  before do
    @vote = FactoryBot.create(:vote, user: FactoryBot.create(:user), votable: FactoryBot.create(:question))
  end

  it { should validate_uniqueness_of(:user).scoped_to(:votable_id, :votable_type).with_message('no unique') }
end
