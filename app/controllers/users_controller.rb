class UsersController < ApplicationController
  
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
                :logo => signup.logo
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
