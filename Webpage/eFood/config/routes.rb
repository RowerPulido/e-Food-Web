Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
<<<<<<< HEAD
  get 'chef_signup', to: 'welcome#newChef'
  get 'login', to: 'welcome#login'
  
  resources :dishes, only: [:index, :create, :show, :update, :destroy]
end
=======
  get 'get/get_client', to: 'apis#get_clients_to_json'
  post 'post/add_clients', to: 'apis#create_clients_to_json'
end
>>>>>>> 6ad289e9feb1633a568b0ce78f157ee1c4aa8875
