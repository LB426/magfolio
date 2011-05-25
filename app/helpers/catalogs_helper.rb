module CatalogsHelper
  
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
          return t('izbrannoe.remove')
        end
      end
    end
    t('izbrannoe.add')
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
    t('default.this_city')
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
  
  def zakaz_phraze(catalog)
    return catalog.zakaz_phraze unless catalog.zakaz_phraze.nil? || catalog.zakaz_phraze.empty?
    t('default.make_order')
  end
  
end
