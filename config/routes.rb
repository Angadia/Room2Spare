Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource  :session, only: [:new, :create, :destroy]

  # I created this route only to test sign in redirection
  get('/', {to: 'welcome#index', as: 'root'})

end
