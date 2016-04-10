Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'pages#frontpage'

  resources :items do
    member do
      get 'upvote'
      get 'crop_image'
      put 'crop_image'
    end
    get 'expensive', on: :collection
  end

  get 'admin/users_count' => 'admin#users_count'

end

