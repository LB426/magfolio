class AboutController < ApplicationController
  
  def index
    @title = t('about.title')
    @body_css_class = "perma about"
  end

end
