class SignupController < ApplicationController
  
  def new
  end
  
  def upgrade
  end
  
  def publish
    render 'signup/free-publish' if params[:id] == 'free'
    render 'signup/pro-publish' if params[:id] == 'pro'
  end
  
end
