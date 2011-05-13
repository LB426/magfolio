class UsersController < ApplicationController
  before_filter :admin_logged_in?
  
  def index
    @users = User.all
  end
  
  def create
    @user = User.new(params[:user])
    @user.open_text_password = params[:user][:password]
    if @user.save
      catalog = create_catalog(params[:signup_id])
      redirect_to root_url, :notice => "Signed up!"
    else
      redirect_to signup_stage3_free_path
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.open_text_password = params[:user][:password]
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_path, :notice => 'Users was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
private
  def create_catalog(signup_id)
    signup = Signup.find(signup_id)
    catalog = @user.catalogs.create(
                :company_name => signup.company_name,
                :businesstype_id => signup.businesstype_id,
                :location_id => signup.location_id,
                :phone => signup.phone,
                :email => signup.email,
                :shortcut_name => signup.shortcut_url,
                :company_url => signup.company_url,
                :tariff => signup.tariff,
                :logo => signup.logo,
                :business_deals => signup.business_deals
              )
    @user.pictures.create(
      :catalog_id => catalog.id,
      :picture => signup.bestpicture,
      :description => signup.bestpic_comment
    )
    signup.destroy
    catalog
  end

end
