class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_access

  def authenticate_access
    redirect_to login_path unless session[:signed_in] || (controller_name == "main" && ["login", "authenticate"].include?(action_name))
  end
end
