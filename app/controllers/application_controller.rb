class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :current_user_self?
  helper_method :is_admin
  helper_method :maindomain
  helper_method :customer?
  helper_method :state_to_string
  
private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Определяет является ли current_user собственником каталога, для того чтобы
  # дать ему возможность редактировать каталог
  def current_user_self?
    return true if !current_user.nil? && current_user.id == @catalog.user_id 
    return true if !current_user.nil? && /admin/ =~ current_user.group
    return false
  end
  
  def is_admin
    unless current_user.nil?
      return true if /admin/ =~ current_user.group
    end
    return false
  end
  
  def maindomain
    "tihinfo.ru"
  end
  
  def find_cart
    @cart = nil
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
    else
    end
    @cart
  end
  
  def customer?(customer_id = nil)
    if current_user
      # поиск customer_id
    else
      unless cookies[:customer].nil?
        return cookies[:customer]
      end
    end
    return nil
  end

protected
  def logged_in?
    unless session[:user_id]
      flash[:notice] = t('messages.auth_required')
      redirect_to new_session_path
      return false
    else
      return true
    end
  end
  
  def registration_upon_request
    unless is_admin
      flash[:notice] = t('registration_upon_request.notice')
      @title = t('registration_upon_request.title')
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
    flash[:notice] = t('admin_logged_in.notice')
    redirect_to new_session_path
    return false
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
        return "http://#{maindomain}"
      end
    end
  end
  
  def state_to_string(state = nil)
    case state
    when 1
      return t('order.state_open')
    when 2
      return t('order.state_close')
    else
      return 'state not defined'
    end
  end
  
end
