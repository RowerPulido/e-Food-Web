Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
  get 'get/get_client', to: 'apis#get_clients_to_json'
  post 'post/add_clients', to: 'apis#create_clients_to_json'
end