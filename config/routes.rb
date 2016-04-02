Rails.application.routes.draw do

  devise_for :users
  root 'items#index'

  resources :items do
    get 'upvote', on: :member
    get 'expensive', on: :collection
  end

end
