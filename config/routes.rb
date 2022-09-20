Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root to: 'questions#index'

  concern :votable do
    member do
      patch :vote_positive
      patch :vote_negative
      delete :cancel_voice
    end
  end

  resources :rewards, only: %i[index]

  resources :questions do
    member do
      delete :destroy_file
      delete :destroy_link
    end
    resources :comments, shallow: true, only: %i[create]
    concerns :votable
    resources :answers, shallow: true, only: %i[show create update destroy] do
      member do
        post :mark_as_best
        delete :destroy_file
        delete :destroy_link
      end
      resources :comments, shallow: true, only: %i[create]
      concerns :votable
    end
  end
end
