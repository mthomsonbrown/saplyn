class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :if => :format_html?
  before_filter :authenticate_user_from_token, :unless => :format_html?
  # I'm not sure what this does, but it fixed the JSON requests...at some point.  
  # Now it looks like I can do whatever I want with this gone.  I'll leave it for now, until I get
  # to adding some tests, and will see if it's important then.
  before_filter :configure_permitted_parameters, if: :devise_controller?, :unless => :format_html?
  
  
  def format_html?
    request.format.html?
  end
  
  def authenticate_user_from_token
    unless authenticate_with_http_token do |token|
      if @current_user = User.find_by(auth_token: token)
        return @current_user
      end
    end
      render json: { error: 'Bad Token'}, status: 401
    end
  end
  
end
