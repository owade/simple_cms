class AccessController < ApplicationController
layout 'admin'

before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
  end

  def login
  end

   def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  private

  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice]="Please Log In"
  		redirect_to(:action => 'login')
  		return false
  	else
  		return true
  	end
  end

  def set_cache_buster
response.headers["Cache-Control"]="no-cache,no-store,max-age=0,must-revalidate"
response.headers["Pragma"]="no-cache"
response.headers["Expires"]="Fri,01 Jan 1990 00:00:00 GMT"
  end

end
