require 'json'
class ApisController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create_clients_to_json
    @json=create_users
  end
  
  def get_clients_to_json
    @json=get_client
  end
  
  private 
  
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
          @json.set! :Payment do
            @json.array! client.payments do |p|
              @json.set! :name, p.name
              @json.set! :street, p.street
              @json.set! :city, p.city
              @json.set! :state, p.state
              @json.set! :postal_code, p.postal_code
              @json.set! :country, p.country
              @json.set! :card_number, p.card_number
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
  
  def create_clients
    @json=Jbuilder.new
    @user=User.new(user_params)
    if @user.save
      @json.category do
        @json.set! :status, 0
        @json.set! :message, "User created"
      end
    elsif @user.username.length<3
      @json.errors do
        @json.set! :status, 1
        @json.set! :reason, "Name cant be blank or Is too short (minimum is 3 characters)"
      end
    elsif User.find_by(username: @user.username)
       @json.errors do
        @json.set! :status, 2
        @json.set! :reason, "Name alrready entered"
      end
    elsif User.find_by(email: @user.email)
      @json.errors do
        @json.set! :status, 3
        @json.set! :reason, "Email alrready used"
      end
    elsif User.find_by(tel: @user.cellphone)
      @json.errors do
        @json.set! :status, 4
        @json.set! :reason, "Phone alrready used"
      end
    elsif @user.tel.length>10 || @user.tel.length<7
      @json.errors do
        @json.set! :status, 5
        @json.set! :reason, "Phone number invalid"
      end
    end
  end
  def user_params
    params.permit(:email, :name, :last_name, :password)
  end
end