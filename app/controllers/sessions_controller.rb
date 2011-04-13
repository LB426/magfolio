class SessionsController < ApplicationController
  
  def new
    @body_css_class = "login"
    @header_layout = 'header'
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id      
      redirect_to catalog_path(user.catalogs.first), :notice => "Logged in!"
    else
      #flash.now.alert = "Invalid email or password"
      redirect_to new_session_path, :notice => "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
