Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
  get 'chef_signup', to: 'welcome#newChef'
  get 'login', to: 'welcome#login'
  
  resources :dishes, only: [:index, :create, :show, :update, :destroy]
end
