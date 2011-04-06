class SignupController < ApplicationController
  
  def new
    @title = "Создание каталога Клевер"
    @body_css_class = "create"
    @header_layout = 'signup/header_new'
    if params[:id].nil?
      @signup = Signup.new
    else
      @signup = Signup.find(params[:id])
    end
    logger.debug "session = #{session}"
    logger.debug "session_id = #{request.session_options[:id]}"
    logger.debug "@signup.id = #{@signup.id}"
  end
  
  def cost
    @title = "Изменение тарифного плана каталога Клевер"
    @body_css_class = "upgrade"
    @header_layout = 'signup/header_cost'
    @signup = Signup.find(params[:id])
    @signup.update_attributes(params[:signup])
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
  
  def bestpictureupload
    @signup = Signup.create( params[:signup] )
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<body><div id=\"signup_id\">#{@signup.id}</div></body>"
  end
  
  def bestpictureurl
    @signup = Signup.find(params[:id])
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<img alt=\"image\" src=\"#{@signup.bestpicture.url(:signup_step_one)}\" />"
  end
  
  def logoupload
    @signup = Signup.find(params[:id])
    @signup.update_attributes(params[:signup])
    render :nothing => true
  end
  
private
  def find_signup
    @signup = (session[:signup] ||= Signup.new)
  end
  
end
