Rails.application.routes.draw do
  # get "books/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # below is to have different version of api, but for this, you will need to amend the file structure as well
  # get "/books" => "books#index"
  # namespace :api do
  #   namespace :v1 do
  #     # resources :books, only: [ :index, :show, :create, :update, :destroy ]
  #     resources :books, only: [ :index ]
  #   end
  # end

  # resources :books, only: [ :index, :show, :create, :update, :destroy ]
  resources :books, only: [ :index, :create, :destroy ]


  # Defines the root path route ("/")
  # root "posts#index"
end
