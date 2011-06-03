class CartographyController < ApplicationController

  def show
    @onload = 'init()'
    @body_css_class = "perma cities"
    @catalog = Catalog.find(params[:catalog_id])
    if @catalog.lat.nil? && @catalog.lng.nil?
      @lon = 40.1257947
      @lat = 45.853046010913
    else
      @lon = @catalog.lng
      @lat = @catalog.lat
    end
    if current_user_self?
      render 'show', :layout => true
    else
      redirect_to root_url, :alert => t('cartography.msg_add_marker_on_map_non_self_alert')
    end
  rescue
    msg = "#{t("default.rescue_error_in_controllers")} CartographyController: #{$!}"
    redirect_to root_url, :alert => msg
  end
  
end