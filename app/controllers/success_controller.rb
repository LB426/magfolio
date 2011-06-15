class SuccessController < ApplicationController
  def index
    @title = "Success story"
    @body_css_class = "perma success about"
  end
end
