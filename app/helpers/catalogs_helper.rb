module CatalogsHelper
  
  # Определяет является ли current_user собственником каталога, для того чтобы
  # дать ему возможность редактировать каталог
  def current_user_self?
    return true if !current_user.nil? && current_user.id == @catalog.user_id 
    return true if !current_user.nil? && /admin/ =~ current_user.group
    return false
  end
  
  # включает обведение блока тёмной полоской для юзера которому разрешено редактировать блок
  def edit_block
    if current_user_self?
      return " edithis"
    else
      return ""
    end
  end
  
  def izbrannoe?(catalog_id)
    unless @izbrannoe.nil?
      @izbrannoe.each do |izbr|
        if izbr.catalog_id == catalog_id
          return "Удалить из избранного"
        end
      end
    end
    "Добавить в избранное"
  end
  
end
