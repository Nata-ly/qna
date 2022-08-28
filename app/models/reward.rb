class Reward < ApplicationRecord
  has_one_attached :image
  belongs_to :user, optional: true
  belongs_to :question

  validates :title, presence: true
end
