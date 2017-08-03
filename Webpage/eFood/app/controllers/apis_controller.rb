require 'json'
class ApisController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def add_client_to_json
    @json=add_client
  end
  
  def update_client_to_json
    @json=update_client
  end
  
  def add_seller_to_json
    @json=add_seller
  end
  
  def update_seller_to_json
    @json=update_seller
  end
  
  def create_clients_to_json
    @json=create_clients
  end
  
  def get_clients_to_json
    @json=get_client
  end
  
  def get_tags_to_json
    @json=get_tags
  end
  
  def get_dishes_to_json
    @json=get_dishes
  end
  
  def get_dishes_by_tag_to_json
    @json=get_dishes_by_tag
  end
  
  def get_kitchen_dishes_to_json
    @json=get_kitchen_dishes
  end
  def get_kitchens_by_brand_to_json
    @json=get_kitchens_by_brand
  end
  
  def get_all_brands_to_json
    @json=get_all_brands
  end
  
  def get_dish_with_kitchen_dishes_to_json
    @json=get_dish_with_kitchen
  end
  
  def get_comments_by_dish_to_json
    @json=get_comments_by_dish
  end

  def add_comment_to_json
    @json=add_comment
  end
  
  def update_comment_to_json
    @json=update_comment
  end
  
  private
  
  def get_dish_with_kitchen
    @json=Jbuilder.new
    if dish=Dish.find_by(id: params[:dish_id]) || dish=Dish.find_by(name: params[:dish_name]) 
      @json.set! dish do
        @json.set! :status, 0
        @json.set! :id, dish.id
        @json.set! :name, dish.name
        @json.set! :preparation_time, dish.preparation_time
        @json.set! :price, dish.price
        @json.set! :Tags do
          @json.array! dish.tags do |dt|
            @json.set! :name, dt.name
          end
        end
        @json.set! :Kitchen do
          @json.set! :id, dish.kitchen.id
          @json.set! :name, dish.kitchen.name
          @json.set! :address, dish.kitchen.address
          @json.set! :zone, dish.kitchen.zone
          @json.set! :Brand do
            @json.set! :id, dish.kitchen.brand.id
            @json.set! :name, dish.kitchen.brand.name
          end
          @json.set! :Owner do
            @json.set! :id, dish.kitchen.seller.user.id
            @json.set! :name, dish.kitchen.seller.user.name
            @json.set! :last_name, dish.kitchen.seller.user.last_name
            @json.set! :cellphone, dish.kitchen.seller.user.cellphone
            @json.set! :email, dish.kitchen.seller.user.email
          end
          @json.set! :Dishes do
            @json.array! dish.kitchen.dishes do |kd|
              @json.set! :name, kd.name
              @json.set! :preparation_time, kd.preparation_time
              @json.set! :price, kd.price
              @json.set! :Tags do
                @json.array! kd.tags do |t|
                  @json.set! :name, t.name
                end
              end
            end
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :message, "dish not found"
      end
    end
  end
  
  def update_comment
    @json=Jbuilder.new
    if dish=Dish.find_by(id: params[:dish_id]) || dish=Dish.find_by(name: params[:dish_name]) 
      if c=dish.comments.find_by(client_id: params[:client_id])  
        if c.update(comment: params[:comment_update])
          @json.set! comments do
            @json.set! :status, 0
            @json.set! :message, "comemnt updated"
          end
        else
          @json.set! :errors do
            @json.set! :status, 1
            @json.set! :message, "unknown error"
          end
        end
      else
        @json.set! :errors do
          @json.set! :status, 1
          @json.set! :message, "Comment not found"
        end
      end
    else
      @json.set! :errors do
        @json.set! :status, 1
        @json.set! :message, "dish not found"
      end
    end
  end
  
  def get_comments_by_dish
    @json=Jbuilder.new
    if 
      @json.set! dish do
        @json.set! :status, 0
        @json.set! :name, dish.name
        @json.set! :Comments do
          @json.array! dish.comments do |d|
            @json.set! :username, d.client.user.name
            @json.set! :comment, d.comment
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :message, "dish not found"
      end
    end
  end
  
  def add_comment
    @json=Jbuilder.new
    comment=Comment.create(client_id: params[:client_id], dish_id: params[:dish_id], comment: params[:comment])
    if comment.save
      @json.set! :comment do
        @json.set! :status, 0
        @json.set! :messege, 'Comment added'
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :message, "dish not found"
      end
    end
  end
  
  def get_all_brands
    @json=Jbuilder.new
    brand=Brand.all
    @json.set! :brands do
      @json.array! brand do |b|
        @json.set! :status, 0
        @json.set! :id, b.id
        @json.set! :name, b.name
      end
    end
  end
  
  def get_brand
    @json=Jbuilder.new
    brand=Brand.find_by(id: params[:brand_id])
    @json.set! :brand do
      @json.set! :status, 0
      @json.set! :id, brand.id
      @json.set! :name, brand.name
    end
  end
  
  def add_brand
    @json=Jbuilder.new
    brand=Brand.new(brand_params)
    errors = false
    error_name = []
    if brand.save
      @json.set! :brand do
        @json.set! :status, 0
        errors = false
        @json.set! :messages, "Marca Registrada"
      end
    end
    if brand.name.length<5 || user.last_name.length>40
      @json.set! :errors do
        errors = true
        error_name.push(["Name format incorrect",1])
        @json.set! :messages, "Error"
      end
    end
    if Brand.find_by(name: brand.name)
      @json.set! :errors do
        errors = true
        error_name.push(["Name already in use",2])
        @json.set! :messages, "Error"
      end
    end
    
    if errors
      @json.set! :errors do
        @json.messages do
          @json.array! (error_name) do |e, s|
            @json.set! :status, s
            @json.set! :description , e
          end
        end
      end
    end
  end
  
  def get_kitchens_by_brand
    @json=Jbuilder.new
    if brand=Brand.find_by(id: params[:brand_id]) || brand=Brand.find_by(name: params[:brand_name])
      @json.set! brand do
        @json.set! :id, brand.id
        @json.set! :name, brand.name
        @json.set! :Kitchens do
          @json.array! brand.kitchens do |k|
            @json.set! :id, k.id
            @json.set! :name, k.name
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :message, "brand not found"
      end
    end
  end
  
  def get_client
    @json=Jbuilder.new
    if client=Client.find_by(user_id: params[:user_id])
      @json.set! client do
        @json.set! :status, 0
        @json.set! :Client do
          @json.set! :id, client.user.id
          @json.set! :email, client.user.email
          @json.set! :name, client.user.name
          @json.set! :last_name, client.user.last_name
          @json.set! :cellphone, client.user.cellphone
          @json.set! :Payments do
            @json.array! client.payments do |p|
              @json.set! :name, p.name
              @json.set! :street, p.street
              @json.set! :city, p.city
              @json.set! :state, p.state
              @json.set! :postal_code, p.postal_code
              @json.set! :country, p.country
              @json.set! :card_number, p.card_number
              @json.set! :expiry_date, p.expiry_date
            end
          end
          @json.set! :Addresses do
            @json.array! client.addresses do |a|
              @json.set! :street, a.street
              @json.set! :city, a.city
              @json.set! :state, a.state
              @json.set! :postal_code, a.postal_code
              @json.set! :country, a.country
            end
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :message, "User not found"
      end
    end
  end
  
  def get_seller_info 
    @json=Jbuilder.new
    if seller=Seller.find_by(id: params[:seller_id])
      @json.set! seller do
        @json.set! :id, seller_id
        @json.set! seller.user do |u|
          @json.set! :name, u.name
          @json.set! :last_name, u.last_name
          @json.set! :email, u.email
          @json.set! :Kitchen do
            @json.array! seller.kitchen do |k|
              @json.set! :id, k.id
              @json.set! :name, k.name
            end
          end
          @json.set! :Brand do
            #if 
          end
        end
      end
    else
      
    end
  end
  
  def get_kitchen_dishes
    @json=Jbuilder.new
    if kitchen=Kitchen.find_by(id: params[:kitchen_id]) || kitchen=Kitchen.find_by(name: params[:kitchen_name])
      @json.set! :kitchen do
        @json.set! :name, kitchen.name
        @json.set! :Dishes do
          @json.array! kitchen.dishes do |d|
            @json.set! :name, d.name
            @json.set! :preparation_time, d.preparation_time
            @json.set! :price, d.price
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :error, "Kitchen not found"
      end
    end
  end
  
  def get_tags
    @json=Jbuilder.new
    tags=Tag.all
    @json.set! :status do 
      @json.set! :status, 0
      @json.set! :Tags do
        @json.array! tags do |t|
         @json.set! :name, t.name 
        end
      end
    end
  end
  
  def get_dishes
    @json=Jbuilder.new
    dishes=Dish.all
    @json.set! :status do
      @json.set! :status, 0
      @json.set! :Dishes do 
        @json.array! dishes do |d|
          @json.set! :name, d.name
        end
      end
    end
  end
  
  def get_dishes_by_tag
    @json=Jbuilder.new
    if tag=Tag.find_by(id: params[:tag_id])
      @json.set! :status, 0
      @json.set! :Tag do 
        @json.set! :name, tag.name
        @json.set! :Dishes do 
          @json.array! tag.dishes do |td|
            @json.set! :name, td.name
            @json.set! :preparation_time, td.preparation_time
            @json.set! :price, td.price
            @json.set! :kitchen_name, td.kitchen.name
          end
        end
      end
    else
      @json.set! :error do
        @json.set! :status, 1
        @json.set! :error, "Tag not found"
      end
    end
  end
  
  def add_client
    @json=Jbuilder.new
    user=User.new(user_params)
    errors = false
    error_name = []
    if user.save && Client.create(user_id: user.id)
      @json.set! :user do
        @json.set! :status, 0
        errors = false
        @json.set! :messages, "Foodie registrado"
      end
    end
    if user.name.length<3 || user.last_name.length<3
      @json.set! :errors do
        errors = true
        error_name.push(["Firts name or Last name cant be blank or are too short (minimum is 3 characters)",1])
        @json.set! :messages, "Error"
      end
    end
    if User.find_by(email: user.email)
      @json.set! :errors do
        errors = true
        error_name.push(["Email alrready used",2])
        @json.set! :messages, "Error"
      end
    end
    if User.find_by(cellphone: user.cellphone)
      @json.set! :errors do
        errors = true
        error_name.push(["Phone alrready used",3])
        @json.set! :messages, "Error"
      end
    end
    if user.cellphone.length>10 || user.cellphone.length<7
      @json.set! :errors do
        errors = true
        error_name.push(["Phone number invalid",4])
        @json.set! :messages, "Error"
      end
    end
    
    if errors
      @json.set! :errors do
        @json.messages do
          @json.array! (error_name) do |e, s|
            @json.set! :status, s
            @json.set! :description , e
          end
        end
      end
    end
  end
  
  def update_client
    @json=Jbuilder.new
    user=User.new(user_params)
    ouser=User.find_by(id: params[:id])
    errors = false
    error_name = []
    if ouser.nil?
        @json.category do
          @json.set! :status, 1
          @json.set! :reason, 'user not foud'
        end
    else
      
      if user.name.length<3 || user.last_name.length<3
        @json.set! :errors do
          errors = true
          error_name.push(["Firts name or Last name cant be blank or are too short (minimum is 3 characters)",1])
          @json.set! :messages, "Error"
        end
      end
      if User.find_by(email: user.email)
        @json.set! :errors do
          errors = true
          error_name.push(["Email alrready used",2])
          @json.set! :messages, "Error"
        end
      end
      if User.find_by(cellphone: user.cellphone)
        @json.set! :errors do
          errors = true
          error_name.push(["Phone alrready used",3])
          @json.set! :messages, "Error"
        end
      end
      if user.cellphone.length>10 || user.cellphone.length<7
        @json.set! :errors do
          errors = true
          error_name.push(["Phone number invalid",4])
          @json.set! :messages, "Error"
        end
      end
      
      if errors
        @json.set! :errors do
          @json.messages do
            @json.array! (error_name) do |e, s|
              @json.set! :status, s
              @json.set! :description , e
            end
          end
        end
      else
        User.update(ouser.id, name: params[:name], email: params[:email], last_name: params[:last_name], cellphone: params[:cellphone], password: params[:password])
        
        @json.category do
        @json.set! :status, 0
        @json.set! :reason, 'Nice ' + user.name.to_s
        end
      end
    end
  end
  
  def add_seller
    @json=Jbuilder.new
    user=User.new(user_params)
    errors = false
    error_name = []
    
    if user.name.length<3 || user.last_name.length<3
      @json.errors do
        errors = true
        error_name.push(["First name or Last name cant be blank or are too short (minimum is 3 characters)",1])
      end
    end
    if User.find_by(email: user.email)
      @json.errors do
        errors = true
        error_name.push(["Email alrready used",2])
        @json.set! :messages, "Error"
      end
    end
    if User.find_by(cellphone: user.cellphone)
      @json.errors do
        errors = true
        error_name.push(["Phone alrready used",3])
        @json.set! :messages, "Error"
      end
    end
    if user.cellphone.length>10 || user.cellphone.length<7
      @json.errors do
        errors = true
        error_name.push(["Phone number invalid",4])
        @json.set! :messages, "Error"
      end
    end
    
    if errors
      @json.set! :errors do
        @json.messages do
          @json.array! (error_name) do |e, s|
            @json.set! :status, s
            @json.set! :description , e
          end
        end
      end
    else
      if user.save && Seller.create(user_id: user.id, RFC: params[:RFC], CLABE: params[:CLABE])
        @json.set! :user do
          @json.set! :status, 0
          errors = false
          @json.set! :message, "Chef registrado"
        end
      end
    end
  end
  
  def update_seller
    @json=Jbuilder.new
    ouser=User.find_by(id: params[:id])
    user=User.new(user_params)
    errors = false
    error_name = []
    if ouser.nil?
        @json.category do
          @json.set! :status, 1
          @json.set! :reason, 'user not foud'
        end
    else
      
      if user.name.length<3 || user.last_name.length<3
        @json.set! :errors do
          errors = true
          error_name.push(["Firts name or Last name cant be blank or are too short (minimum is 3 characters)",1])
          @json.set! :messages, "Error"
        end
      end
      if User.find_by(email: user.email)
        @json.set! :errors do
          errors = true
          error_name.push(["Email alrready used",2])
          @json.set! :messages, "Error"
        end
      end
      if User.find_by(cellphone: user.cellphone)
        @json.set! :errors do
          errors = true
          error_name.push(["Phone alrready used",3])
          @json.set! :messages, "Error"
        end
      end
      if user.cellphone.length>10 || user.cellphone.length<7
        @json.set! :errors do
          errors = true
          error_name.push(["Phone number invalid",4])
          @json.set! :messages, "Error"
        end
      end
      
      if errors
        @json.set! :errors do
          @json.messages do
            @json.array! (error_name) do |e, s|
              @json.set! :status, s
              @json.set! :description , e
            end
          end
        end
      else
        User.update(ouser.id, name: params[:name], email: params[:email], last_name: params[:last_name], cellphone: params[:cellphone], password: params[:password])
        s = Seller.find_by(user_id: ouser.id)
        Seller.update(s.id, CLABE: params[:CLABE])
        @json.category do
        @json.set! :status, 0
        @json.set! :reason, 'Nice ' + user.name.to_s
        end
      end
    end
  end
  
  def user_params
    params.permit(:email, :name, :last_name, :cellphone, :password)
  end

  def seller_params
    params.permit(:email, :name, :last_name, :cellphone, :password, :RFC, :CLABE)
  end
  def brand_params
    params.permit(:name)
  end
end
