module CatalogsHelper
  
  def edit_block
    if current_user
      return " edithis"
    else
      return ""
    end
  end
  
end
