module ApplicationHelper
  
  def render_title
    return @title if defined?(@title)
    "Клевер, каталоги онлайн"
  end
  
  def body_style
    return @body_css_class if defined?(@body_css_class)
    "home"
  end
  
  def render_header
    if defined?(@header_layout)
      render @header_layout
    else
      render 'layouts/header'
    end
  end
  
end
