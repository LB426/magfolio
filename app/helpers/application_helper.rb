module ApplicationHelper
  def render_title
    return @title if defined?(@title)
    "Клевер, каталоги онлайн"
  end
end
