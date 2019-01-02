Poshvine::Application.routes.draw do
  get "attachement/index"

  get "attachement/new"

  get "attachement/create"

  get "attachement/destroy"

  resources :users do
    collection do
      get :create_user
      post :search
      delete :destroy
      post :import_users
      get :import_view
    end
  end
  root to: 'users#index'
end
