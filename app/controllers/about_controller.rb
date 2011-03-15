class AboutController < ApplicationController
  
  def index
    @title = "О веб каталогах Клевер"
    @body_css_class = "perma about"
    @header_layout = 'about/header'
  end

end
