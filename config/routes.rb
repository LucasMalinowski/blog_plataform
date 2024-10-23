Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts do
    resources :comments, only: [:create, :destroy]

  end

  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :comments, only: [:create, :destroy, :index]
      end
    end
  end

end