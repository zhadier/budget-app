Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # authenticated :user do
  #   root 'calendars#index', as: :authenticated_root
  # end
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  unauthenticated :user do
    root 'pages#splash', as: :unauthenticated_root
  end
end
