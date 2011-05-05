class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :is_admin
  
private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def is_admin
    unless current_user.nil?
      return true if /admin/ =~ current_user.group
    end
    return false
  end

protected
  def logged_in?
    unless session[:user_id]
      flash[:notice] = "Вы не вошли в каталог."
      redirect_to new_session_path
      return false
    else
      return true
    end
  end
  
  def registration_upon_request
    unless is_admin
      flash[:notice] = "Извините в настоящий момент регистрация новых пользователей доступна только по приглашению."
      @title = "Получение приглашения"
      @body_css_class = "perma about"
      render 'signup/registration-upon-request'
      return false
    else
      return true
    end
  end
  
  def admin_logged_in?
    unless current_user.nil?
      if /admin/ =~ current_user.group
        return true 
      end
    end
    flash[:notice] = "Вы должны быть администратором для этого."
    redirect_to new_session_path
    return false
  end
  
  def maindomain
    "klever.spknd.ru"
  end
  
  def myhost(city_name = nil)
    unless city_name.nil?
      if Rails.env == 'development'
        return "http://localhost:3000/city/#{city_name}"
      else
        return "http://#{maindomain}/city/#{city_name}"
      end
    else
      if Rails.env == 'development'
        return "http://localhost:3000"
      else
        return "http://#{}"
      end
    end
  end
  
end
