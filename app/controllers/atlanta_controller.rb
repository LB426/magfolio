class AtlantaController < ApplicationController
  def index
    @body_css_class = "home listings"
    @header_layout = 'atlanta/header'
  end

end
