class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user, uniqueness: { scope: %i[votable_id votable_type], message: 'no unique' }
end
