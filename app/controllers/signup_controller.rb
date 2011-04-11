class SignupController < ApplicationController
  
  def stage1
    @title = "Создание каталога Клевер"
    @body_css_class = "create"
    @header_layout = 'signup/header_stage1'
    @signup = find_signup
    @business_types = BusinessType.all
    @business_type = BusinessType.new
    @locations = Location.all
    @location = Location.new
    logger.debug "session = #{session}"
    logger.debug "session_id = #{request.session_options[:id]}"
    rescue ActiveRecord::RecordNotFound
      redirect_to signup_path
  end
  
  def stage2
    @title = "Изменение тарифного плана каталога Клевер"
    @body_css_class = "upgrade"
    @header_layout = 'signup/header_stage2'
    @signup = find_signup
    @signup.update_attributes(params[:signup])
    rescue ActiveRecord::RecordNotFound
      redirect_to signup_path
  end
  
  def stage3free
    @header_layout = 'signup/header_stage3'
    @body_css_class = 'publish free'
    @signup = find_signup
    @signup.tariff = 'free'
    @signup.save
    render 'signup/stage3-free'
  end
  
  def stage3pay
    @header_layout = 'signup/header_stage3'
    @body_css_class = 'publish pro'
    @signup = find_signup
    @signup.tariff = 'pay'
    @signup.save
    render 'signup/stage3-pay'
  end
  
  def bestpictureupload
    @signup = Signup.create( params[:signup] )
    @signup.session_id = request.session_options[:id]
    @signup.save
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<body><div id=\"signup_id\">#{@signup.id}</div></body>"
  end
  
  def bestpictureurl
    @signup = find_signup
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<img alt=\"image\" src=\"#{@signup.bestpicture.url(:small)}\" />"
  end
  
  def logoupload
    @signup = find_signup
    @signup.update_attributes(params[:signup])
    render :nothing => true
  end
  
private
  def find_signup
    #@signup = (session[:id] ||= Signup.new)
    signup = Signup.find_by_session_id(request.session_options[:id])
    signup = Signup.new if signup.nil?
    signup
  end
  
end
