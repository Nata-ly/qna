class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files

  validates :title, :body, presence: true
end
