class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticate_user_from_token, :only => [:create, :sign_in]
  skip_before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token
  
  rescue_from ActiveRecord::RecordInvalid do
    render :text => 'Ya done screwed up', :success => false, :status => :unprocessable_entity
  end
  
  # POST /users.json
  def create
    @user = User.create! user_params
    render json: { data: { auth_token: @user.auth_token }}
  end
  
  def index 
      render json: { thingy: "Got to index!" }
  end
  
  
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, 
      :username, :auth_token)
  end
  
end