class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :vkontakte]

  has_many :answers
  has_many :comment, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :questions
  has_one  :reward
  has_many :votes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def have_subscription?(question)
    question.subscriptions.where(user: self).exists?
  end

  def self.find_for_oauth(auth)
    FindForOauthService.new(auth).call
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def author_of?(resource)
    resource.user_id == id
  end
end
