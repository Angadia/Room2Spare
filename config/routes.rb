Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :facilities do
    resources :rooms, shallow: true
  end

  resources :users, only:   [:new, :create, :edit, :update]
  resource  :session, only: [:new, :create, :destroy]

  resources :courses

  get('/', {to: 'welcome#index', as: 'root'}) #created this welcome app just to test login and sign up

end
