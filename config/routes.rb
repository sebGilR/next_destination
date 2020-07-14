Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :destinations
      resources :favorites, only: [:index, :create, :destroy]
      resources :users, only: [:create, :destroy]
      post 'auth/login', to: 'sessions#create'
      delete 'auth/logout', to: 'sessions#destroy'
      get 'auth/connected', to: 'sessions#connected'
    end
  end
end
