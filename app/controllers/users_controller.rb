# The users controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_filter :verify_authenticity_token

  # GET /users
  # GET /users.json
  def index
    @user = current_user
    @posts = current_user.all_posts
  end

  # GET /users/1
  # GET /users/1.json
  def show
    logger.info("In show, user is #{@user}")
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new user_params
  end

  # Internal: respond to a create request
  def do_create
    respond_to do |format|
      if @user.save
        format_html 'User was successfully created.'
        format.json { render :show, status: :created, location: @user }
      else
        respond_with_error :new
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update user_params
        format_html 'User was successfully updated.'
        format.json { render :show, status: :ok, location: @user }
      else
        respond_with_error :edit
      end
    end
  end

  # Internal: sends appropriate variables to an html request
  def format_html(message)
    format.html do
      redirect_to @user, notice: message
    end
  end

  # Internal: compiles an error method in both html and json
  def respond_with_error(method)
    format.html { render method }
    format.json { render json: @user.errors, status: :unprocessable_entity }
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url,
                    notice: 'User was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def user_params
    params.fetch(:user, {})
  end
end
