Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'items#index'

  resources :items do
    get 'upvote', on: :member
    get 'expensive', on: :collection
  end

  get 'admin/users_count' => 'admin#users_count'

end

