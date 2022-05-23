Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  
  authenticated :user do
    root 'groups#index', as: :authenticated_root
  end

  unauthenticated :user do
    root 'pages#splash', as: :unauthenticated_root
  end

  resources :groups, only: %i[index new create destroy] do
    resources :expenses, only: %i[index new create destroy]
  end
end
