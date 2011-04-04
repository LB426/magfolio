class SignupController < ApplicationController
  
  def new
    @title = "Создание каталога Клевер"
    @body_css_class = "create"
    @header_layout = 'signup/header_new'
    @signup = Signup.new
  end
  
  def upgrade
    @title = "Изменение тарифного плана каталога Клевер"
    @body_css_class = "upgrade"
    @header_layout = 'signup/header_upgrade'
  end
  
  def publish
    @header_layout = 'signup/header_upgrade_free'
    if params[:id] == 'free'
      @body_css_class = 'publish free'
      render 'signup/free-publish'
    end
    if params[:id] == 'pro'
      @body_css_class = 'publish pro'
      render 'signup/pro-publish'
    end
  end
  
  def logoupload
    @signup = Signup.create( params[:user] )
    render :nothing => true
  end
  
end
