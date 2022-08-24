Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true, only: %i[show create update destroy] do
      member do
        post :mark_as_best
      end
    end
  end
end
