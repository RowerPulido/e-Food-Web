Rails.application.routes.draw do
  get 'user/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'signup', to: 'welcome#new'
  get 'login', to: 'welcome#login'
  get 'carro', to: 'welcome#pedido'
  
  
  
  #apis
  get 'api/getClient', to: 'apis#get_clients_to_json'
  get 'api/getAllBrands', to: 'apis#get_all_brands_to_json'
  get 'api/getAllTags', to: 'apis#get_tags_to_json'
  get 'api/getAllDishes', to: 'apis#get_dishes_to_json'
  get 'api/getKitchensByBrand', to: 'apis#get_kitchens_by_brand_to_json'
  get 'api/getKitchenDishes', to: 'apis#get_kitchen_dishes_to_json'
  get 'api/getDishesByTag', to: 'apis#get_dishes_by_tag_to_json'
  get 'api/getDishWithKitchen', to: 'apis#get_dish_with_kitchen_dishes_to_json'
  get 'api/getCommentsByDish', to: 'apis#get_comments_by_dish_to_json'
  get 'api/getEvaluationByDish', to: 'apis#get_evaluataion_by_dish_to_json'
  post 'api/addEvaluation', to: 'apis#add_evaluation_to_json'
  post 'api/addClient', to: 'apis#add_client_to_json'
  post 'api/updClient', to: 'apis#add_client_to_json'
  post 'api/addSeller', to: 'apis#add_seller_to_json'
  post 'api/addComment', to: 'apis#add_comment_to_json'
  post 'api/updComment', to: 'apis#update_comment_to_json'
  post 'api/updSeller', to: 'apis#add_seller_to_json'
  
  resources :dishes, only: [:index, :create, :show, :update, :destroy]
end
