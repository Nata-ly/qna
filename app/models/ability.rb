# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment, ActiveStorage::Attachment, Link, Subscription]
    can [:update, :destroy], [Question, Answer, Comment], user_id: user.id
    can :destroy, Subscription, user_id: user.id

    can [:vote_positive, :vote_negative, :cancel_voice], [Question, Answer] do |resource|
      !user.author_of?(resource)
    end

    can [:destroy_file, :destroy_link], [Question, Answer], user_id: user.id

    can :mark_as_best, Answer do |resource|
      user.author_of?(resource.question) && resource.question.best_answer != resource
    end
  end

  def guest_abilities
    can :read, :all
    can :finish_signup, [User]
  end
end
