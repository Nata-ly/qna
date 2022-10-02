Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }
  root to: 'questions#index'
  post '/users/finish_signup' => 'users#finish_signup'

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

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [:index] do
        get :me, on: :collection
      end

      resources :questions, only: [:index]
    end
  end

end
