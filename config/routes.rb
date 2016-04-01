Rails.application.routes.draw do
  resources :customers
  resources :stocks
  get 'welcome/index'

  #get 'admin/index'
  get 'admin' => 'admin#index'

  #get 'users/sign_in', :as => 'loginsite'
  devise_scope :user do
    get "/loginsistema" => "devise/sessions#new"
  end

  devise_for :users
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'

  resources :products

  root :to => 'welcome#index', :as => 'welcome'
  #root :to => 'store#index', :as => 'store'

end
