module ApplicationHelper
  
  def render_title
    return @title if defined?(@title)
    t('default.page_title')
  end
  
  def body_style
    return @body_css_class if defined?(@body_css_class)
    "perma cities"
  end
  
  def render_header
    if defined?(@header_layout)
      render @header_layout
    else
      render 'layouts/header'
    end
  end
  
  def izbrannoe_count
    unless cookies[:izbrannoe].nil?
      return "(#{Izbrannoe.find_all_by_identificator(cookies[:izbrannoe]).count})"
    end
    ""
  end
  
  def cart_exist?
    @cart_count = 0
    unless cookies[:cart].nil?
      cart = Cart.find_by_unique_identifier(cookies[:cart])
      @cart_count = cart.all_products_count
      return true
    end
    return false
  end
    
end
