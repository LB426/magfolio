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
  
  def current_host
    if Rails.env == 'development'
      if request.host =~ /^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$/
        return "http://#{request.host}:3000"
      else
        return "http://localhost:3000"
      end
    else
      if request.host =~ /^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$/
        return "http://#{request.host}"
      else
        return "http://#{maindomain}"
      end
    end
  end
  
  # генерит ссылку для списка городов
  def location_link(city_name)
    unless city_name.nil?
      return URI.encode("#{current_host}/city/#{city_name}")
    else
      return "#{current_host}"
    end
  end
  
  # генерит имя текущего города, если есть сортировка по этому городу
  def this_city
    unless @location.nil?
      return @location.name
    end
    "Городе"
  end
  
  # генерим ссылку для товаров
  def product_link(product_name = nil)
    unless product_name.nil?
      unless @location.nil? 
        return URI.encode("#{current_host}/city/#{@location.name}/product/#{product_name}")
      else
        return URI.encode("#{current_host}/product/#{product_name}")
      end
    else
      return "#{current_host}"
    end   
  end
  
  def service_link(service_name = nil)
    unless service_name.nil?
      unless @location.nil?       
        return URI.encode("#{current_host}/city/#{@location.name}/service/#{service_name}")
      else
        return URI.encode("#{current_host}/service/#{service_name}")
      end
    else
      return "#{current_host}"
    end   
  end
  
end
