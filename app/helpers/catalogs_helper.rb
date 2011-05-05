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
    unless cookies[:izbrannoe].nil?
      izbrannoe = Izbrannoe.find_all_by_identificator(cookies[:izbrannoe])
      izbrannoe.each do |izbr|
        if izbr.catalog_id == catalog_id
          return "Удалить из избранного"
        end
      end
    end
    "Добавить в избранное"
  end
  
  def location_link(city_name)
    unless city_name.nil?
      if Rails.env == 'development'
        return URI.encode("http://localhost:3000/city/#{city_name}")
      else
        return URI.encode("http://klever.spknd.ru/city/#{city_name}")
      end
    else
      if Rails.env == 'development'
        return "http://klever.spknd.ru:3000"
      else
        return "http://klever.spknd.ru"
      end
    end
  end
  
  def this_city
    unless @location.nil?
      return @location.name
    end
    "Городе"
  end
  
end
