Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
  get 'get/get_client', to: 'apis#get_clients_to_json'
  get 'get/get_all_brands', to: 'apis#get_all_brands_to_json'
  get 'get/get_tags', to: 'apis#get_tags_to_json'
  get 'get/get_dishes', to: 'apis#get_dishes_to_json'
  get 'get/get_kitchen_dishes', to: 'apis#get_kitchen_dishes_to_json'
  get 'get/get_dishes_by_tag', to: 'apis#get_dishes_by_tag_to_json'
  get 'get/get_dish_with_kitchen_dishes', to: 'apis#get_dish_with_kitchen_dishes_to_json'
  post 'post/add_client', to: 'apis#add_client_to_json'
  post 'post/add_seller', to: 'apis#add_seller_to_json'
  
  resources :dishes, only: [:index, :create, :show, :update, :destroy]
end
