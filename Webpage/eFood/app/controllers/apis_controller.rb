require 'json'
class ApisController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def add_client_to_json
    @json=add_client
  end
  
  def add_seller_to_json
    @josn=add_seller
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
  
  def get_brands_to_json
    @json=get_brands
  end
  
  private 
  
  def get_brands
    @json=Jbuilder.new
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
  
  def get_kitchen_dishes
    @json=Jbuilder.new
    if kitchen=Kitchen.find_by(id: params[:kitchen_id])
      @json.set! kitchen do
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
        @json.set! :messages, "Error"
        errors = true
        error_name.push(["Firts name or Last name cant be blank or are too short (minimum is 3 characters)",1])
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
  
    def add_seller
    @json=Jbuilder.new
    user=User.new(user_params)
    if user.save && Seller.create(user_id: user.id, RFC: params[:RFC], CLABE: params[:CLABE])
      @json.set! :user do
        @json.set! :status, 0
        @json.set! :message, "Foodie registrado"
      end
    elsif user.name.length<3 || user.last_name.length<3
      @json.errors do
        @json.set! :status, 1
        @json.set! :reason, "Firts name or Last name cant be blank or are too short (minimum is 3 characters)"
      end
    elsif User.find_by(email: user.email)
      @json.errors do
        @json.set! :status, 2
        @json.set! :reason, "Email alrready used"
      end
    elsif User.find_by(cellphone: user.cellphone)
      @json.errors do
        @json.set! :status, 3
        @json.set! :reason, "Phone alrready used"
      end
    elsif user.cellphone.length>10 || user.cellphone.length<7
      @json.errors do
        @json.set! :status, 4
        @json.set! :reason, "Phone number invalid"
      end
    end
  end
  
  
  
  def user_params
    params.permit(:email, :name, :last_name, :cellphone, :password)
  end
  def seller_params
    params.permit(:email, :name, :last_name, :cellphone, :password, :RFC, :CLABE)
  end
end
