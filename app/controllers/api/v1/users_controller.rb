class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticate_user_from_token, :only => [:create, :sign_in]
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: {RecordInvalid: e.record.errors}}, status: 422
  end
  
  # POST /users.json
  def create
    user = User.create! user_params
    render :json =>  {user: user}
  end
  
  def sign_in
    user = User.find_by(email: user_params[:email])
    if user && user.valid_password?(user_params[:password])
      render :json => {user: user}
    else
      render json: {error: 'Incorrect credentials'}, status: 401
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