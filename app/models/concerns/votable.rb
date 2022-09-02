module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def vote_value
    votes.where(solution: true).count - votes.where(solution: false).count
  end
end
