Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', { to: 'posts#index', as: 'root' })
  get('/users/:id/change_password', {to: 'users#change_password', as: 'change_password'})
  patch('/users/:id/change_password', {to: 'users#update_password', as: 'update_password'})
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments, only: [:create, :destroy], shallow: true
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :posts, only: [:index, :show, :update, :create, :destroy]
      resource :session, only: [:create, :destroy]
      resources :users, only: [:index, :show, :create]
    end
  end

end
