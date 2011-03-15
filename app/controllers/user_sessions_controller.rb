class UserSessionsController < ApplicationController
  
  def new
    @body_css_class = "login"
    @header_layout = 'user_sessions/header'
  end
  
end
