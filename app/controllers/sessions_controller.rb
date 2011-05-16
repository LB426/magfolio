class SessionsController < ApplicationController
  
  def new
    @body_css_class = "login"
    # @header_layout = 'header'
    @email = ''
    @password = ''
    if cookies[:remember_me]
      user = User.find_by_remember_me_token(cookies[:remember_me])
      if user
        @email = user.email
        @password = "установлена кука remember_me"
      else
        cookies.delete(:remember_me)
        redirect_to new_session_path, :alert => "Был выполнен вход с другого компьютера. Все сессии уничтожены введите логин и пароль!"
      end
    end
  end
  
  def create
    user = nil
    if cookies[:remember_me]
      user = User.find_by_remember_me_token(cookies[:remember_me])
    else
      user = User.authenticate(params[:email], params[:password])
    end
    if user
      session[:user_id] = user.id
      unless params[:remember_me].nil?
        user.remember_me_token = BCrypt::Engine.hash_secret("#{random_string}", BCrypt::Engine.generate_salt)
        user.save
        cookies[:remember_me] = {
          :value => user.remember_me_token,
          :expires => 1.year.from_now,
          :path => '/'
        }
      else
        user.remember_me_token = nil
        user.save
        cookies.delete(:remember_me)
      end

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
    reset_session
    redirect_to root_path
  end

  def rememberme
    user = User.authenticate(params[:email], params[:password])
    if user
      remember_me_token = BCrypt::Engine.hash_secret("#{request.remote_ip}", BCrypt::Engine.generate_salt)
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => [remember_me_token].to_json( :only => [ :remember_me_token ] )
    else
      response.headers['Content-type'] = "text/plain; charset=utf-8"
      render :text => ['authorise non successfull'].to_json( :only => [ :remember_me_token ] )
    end
    rescue
      render :nothing => true
  end

private

  def random_string(size = 32)
    chars = (('a'..'z').to_a + ('0'..'9').to_a)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

end
