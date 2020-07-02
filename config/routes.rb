Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }

  resources :users, :only => [:index]

  get "pages/home" => "pages#home"

  root 'posts#index'

  get '/users/:id', to: 'users#show', as: 'user'

  resources :posts, only: %i(index new create show destroy) do
    resources :photos, only: %i(create)
    resources :likes, only: [:create, :destroy]
  end
end
