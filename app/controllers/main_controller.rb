class MainController < ApplicationController
  def index
    @projects = @focus_quarter.projects
  end

  def login
  end

  def authenticate
    session[:signed_in] = true if params[:password] == ENV['APP_PASSWORD']
    redirect_to root_path
  end

  def logout
    session[:signed_in] = false
    redirect_to root_path
  end
end
