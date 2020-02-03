Rails.application.routes.draw do
  root "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :facilities do
    resources :rooms, shallow: true
  end

  resources :users, only:   [:new, :create, :edit, :update]
  resource  :session, only: [:new, :create, :destroy]

  resources :courses
  post 'courses/:id/drop', to: 'courses#drop', as: :drop_course
  post 'courses/:id/enroll', to: 'courses#enroll', as: :enroll_course

  get('/', {to: 'welcome#index', as: 'root'}) #created this welcome app just to test login and sign up

end
