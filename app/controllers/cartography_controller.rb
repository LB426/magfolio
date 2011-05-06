class CartographyController < ApplicationController
  before_filter :admin_logged_in?
  
  def index
    @body_css_class = "perma cities"
  end
end