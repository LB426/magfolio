module CatalogsHelper
  
  # Определяет является ли current_user собственником каталога, для того чтобы
  # дать ему возможность редактировать каталог
  def current_user_self?
    return true if current_user.id == @catalog.user_id
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
  
end
