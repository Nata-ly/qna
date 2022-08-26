Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions do
    member do
      delete :destroy_file
    end
    resources :answers, shallow: true, only: %i[show create update destroy] do
      member do
        post :mark_as_best
        delete :destroy_file
      end
    end
  end
end
