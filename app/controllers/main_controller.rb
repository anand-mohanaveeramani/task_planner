class MainController < ApplicationController
  def index
  end

  def login
  end

  def authenticate
    session[:signed_in] = true if params[:password] == "sdf"
    redirect_to root_path
  end

  def logout
    session[:signed_in] = false
    redirect_to root_path
  end
end
