class SignupController < ApplicationController
  
  def new
    @title = "Создание каталога Клевер"
    @body_css_class = "create"
    @header_layout = 'signup/header_new'
    @signup = Signup.new
    logger.debug "session = #{session}"
    logger.debug "session_id = #{request.session_options[:id]}"
    logger.debug "@signup.id = #{@signup.id}"
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
    logger.debug "logoupload, session_id = #{request.session_options[:id]}"
    @signup = Signup.create( params[:signup] )
    #render :nothing => true
    #response.headers['Content-type'] = "text/plain; charset=utf-8"
    #render :text => @signup.to_json(:only => [ :id ])
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<body><div id=\"signup_id\">#{@signup.id}</div></body>"
  end
  
private
  def find_signup
    @signup = (session[:signup] ||= Signup.new)
  end
  
end
