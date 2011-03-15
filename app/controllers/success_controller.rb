class SuccessController < ApplicationController
  def index
    @title = "Истории успеха с каталогом Клевер"
    @body_css_class = "perma success about"
  end
end
