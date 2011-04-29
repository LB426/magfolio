class SignupController < ApplicationController
  before_filter :registration_upon_request
  
  def stage1
    @title = "Создание каталога Клевер"
    @body_css_class = "create"
    @header_layout = 'signup/header_stage1'
    @signup = find_signup
    @business_types = BusinessType.all
    @business_type = BusinessType.new
    @locations = Location.all
    @location = Location.new
    @business_deals = BusinessDeal.all
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
    @user = User.new
    @random_password = random_password
    rescue ActiveRecord::RecordNotFound
      redirect_to signup_path
  end
  
  def stage3pay
    @header_layout = 'signup/header_stage3'
    @body_css_class = 'publish pro'
    @signup = find_signup
    @signup.tariff = 'pay'
    @signup.save
    rescue ActiveRecord::RecordNotFound
      redirect_to signup_path
  end
  
  def bestpictureupload
    @signup = find_signup
    @signup.session_id = request.session_options[:id]
    #@signup = Signup.create( params[:signup] )
    @signup.update_attributes(params[:signup])
    #@signup.session_id = request.session_options[:id]
    #@signup.save
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<body><div id=\"signup_id\">#{@signup.id}</div></body>"
  end
  
  def bestpictureurl
    @signup = find_signup
    logger.debug "1111111=#{@signup.bestpicture.url(:small)}"
    response.headers['Content-type'] = "text/html; charset=utf-8"
    render :text => "<img alt=\"image\" src=\"#{@signup.bestpicture.url(:small)}\" />"
  end
  
  def logoupload
    @signup = find_signup
    @signup.update_attributes(params[:signup])
    render :nothing => true
  end
  
  def setbusinessdeal
    business_deals = params[:business_deals]
    unless business_deals.nil?
      business_deal_ids = Array.new
      business_deals.each_key do |key|
        business_deal_ids << key
      end
      @signup = find_signup
      @signup.business_deals = business_deal_ids
      @signup.save
    end
    
    render :nothing => true
  end
  
  def getbusinessdeals
    @signup = find_signup
    business_deals = BusinessDeal.find(@signup.business_deals)
    arr_bd = Array.new
    business_deals.each do |business_deal|
      logger.debug "business_deal = #{business_deal.name} #{business_deal.kind}"
      arr_bd << { :id => business_deal.id, :name => "#{business_deal.name} #{business_deal.kind}" }
    end
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    render :text => arr_bd.to_json( :only => [ :id, :name ] )
    rescue ActiveRecord::RecordNotFound
      render :nothing => true
  end
  
private
  def find_signup
    signup = Signup.find_by_session_id(request.session_options[:id])
    signup = Signup.new if signup.nil?
    signup
  end
  
  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
  
end
