Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
  get 'get/getClient', to: 'apis#get_clients_to_json'
  get 'get/getAllBrands', to: 'apis#get_all_brands_to_json'
  get 'get/getTags', to: 'apis#get_tags_to_json'
  get 'get/getDishes', to: 'apis#get_dishes_to_json'
  get 'get/getKitchensByBrand', to: 'apis#get_kitchens_by_brand_to_json'
  get 'get/getKitchenDishes', to: 'apis#get_kitchen_dishes_to_json'
  get 'get/getDishesByTag', to: 'apis#get_dishes_by_tag_to_json'
  get 'get/getDishWithKitchenDishes', to: 'apis#get_dish_with_kitchen_dishes_to_json'
  post 'post/addClient', to: 'apis#add_client_to_json'
  post 'post/addSeller', to: 'apis#add_seller_to_json'
  
  resources :dishes, only: [:index, :create, :show, :update, :destroy]
end
