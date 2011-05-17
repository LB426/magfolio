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

  def resetpassword
    @body_css_class = "login"
  end
  
  def sendresetpasswordmail
    user = User.find_by_email(params[:email])
    if user
      user.reset_password_token = random_string(64)
      user.save
      ResetPassword.reset_password_email(user).deliver
      redirect_to login_path, :notice => "Письмо для восстановления пароля отправлено на адрес #{params[:email]}."
    else
      redirect_to resetpassword_path, :alert => "Указанный Вами адрес #{params[:email]} не найден в адресах пользователей каталога."
    end
  end
  
  def edituser
    @body_css_class = "login"
    @user = User.find_by_reset_password_token(params[:reset_password_token])
    unless @user
      redirect_to login_path, :alert => "Пользователь не найден."
    end
  end
  
  def updatepassword
    @user = User.find_by_reset_password_token(params[:reset_password_token])
    if @user
      if params[:password].size < 6
        redirect_to edit_user_with_rptoken_path(@user.reset_password_token), :alert => "Пароль должен быть из 6 или более знаков"
      else
        @user.reset_password_token = nil
        if @user.update_attributes({:password => params[:password]})
          redirect_to login_path, :notice => "Пароль изменён, можете войти с новым паролем."
        else
          redirect_to login_path, :notice => "Не удалось изменить пароль."
        end
      end
    else
      redirect_to login_path, :alert => "Пользователь не найден."
    end
  end

private

  def random_string(size = 32)
    chars = (('a'..'z').to_a + ('0'..'9').to_a)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

end
