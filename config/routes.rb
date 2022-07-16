Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles
    end
  end
  require 'sidekiq/web'
  mount Sidekiq::Web=> "/sidekiq"
  devise_for :accounts
  root "articles#index"


  resources :articles  do
    resources :comments


    # get "/accounts/activate/:id", as:"activate", to: "accounts#activate"

    # get "/accounts_reports", as:"reports", to: "accounts#reports"
  end
  resources :accounts do
    collection {post :import}
  end

  get "accounts/activate/:id" ,as:"activate", to: "accounts#activate"
  post "/accounts/create_acc", as:"create_acc", to: "accounts#create"
  get "/accounts_reports_all", as:"reports", to: "accounts#reports"
  get "accounts_downloads",as:"reports_all", to: "accounts#export_all"
  get "accounts_download",as:"reports_acc", to: "accounts#export"
  get "articles_downloads",as:"reports_post", to: "articles#export_articles"

  get "accounts_upload", as:"upload", to:"accounts#upload"
  # get "" "accounts#show"
  # root "accounts#new"
  resources :likes, only: [:create, :destroy]
  get 'homepage',as:"homepage", to: 'articles#home'
end
