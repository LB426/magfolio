class HomeController < ApplicationController
  def index
    @header_layout = 'home/header'
    @body_css_class = "home"
  end

end
