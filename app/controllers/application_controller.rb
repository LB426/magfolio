class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
    unless session[:user_id]
      flash[:notice] = "Извините в настоящий момент регистрация новых пользователей доступна только по приглашению."
      @title = "Получение приглашения"
      @body_css_class = "perma about"
      render 'signup/registration-upon-request'
      return false
    else
      return true
    end
  end
  
end
