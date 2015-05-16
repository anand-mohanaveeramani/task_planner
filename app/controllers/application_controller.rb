class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_access
  before_filter :focus_quarter

  helper_method :focus_quarter

  def authenticate_access
    redirect_to login_path unless session[:signed_in] || (controller_name == "main" && ["login", "authenticate"].include?(action_name))
  end

  def focus_quarter
    @focus_quarter ||= Quarter.find_by(year: Time.now.year, index: (1 + ((Time.now.month-1)/3).to_i))
  end
end
