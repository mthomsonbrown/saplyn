class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticate_user_from_token, :only => [:create, :sign_in]
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  
  rescue_from ActiveRecord::RecordInvalid do
    render :text => 'Ya done screwed up', :success => false, :status => :unprocessable_entity
  end
  
  # POST /users.json
  def create
    @user = User.create! user_params
    render json: { data: { auth_token: @user.auth_token, user_id: @user.id }}
  end
  
  def sign_in
    user = User.find_by(email: user_params[:email])
      if user && user.password == user_params[:password]
        render :json => user
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
  end
  
  def index 
    render :json => current_user
  end
  
  def update
    current_user.update user_params
    render :json => current_user
  end
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, 
      :username, :auth_token, :created_at, :current_sign_in_at)
  end
  
end