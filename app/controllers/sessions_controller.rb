class SessionsController < ApplicationController
  
  def new
    @body_css_class = "login"
    @header_layout = 'header'
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      unless user.catalogs.first.nil?
        redirect_to catalog_path(user.catalogs.first)
      else
        redirect_to signup_path
      end
    else
      redirect_to new_session_path, :alert => "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
