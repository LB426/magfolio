class Array
  def randomize
    self.sort_by { rand }
  end
  
  def randomize!
    self.replace(self.randomize)
  end
end

class CatalogsController < ApplicationController
  # GET /catalogs
  # GET /catalogs.xml
  def index
    @header_layout = 'catalogs/header'
    @body_css_class = "home"
    
    logger.debug "cookies[:izbrannoe]=#{cookies[:izbrannoe]}"
    
    unless cookies[:izbrannoe].nil?
      @izbrannoe = Izbrannoe.find_all_by_identificator(cookies[:izbrannoe])
    end

    logger.debug "request.domain=#{request.domain}"
    logger.debug "request.fullpath=#{request.fullpath}"
    logger.debug "request.url=#{request.url}"
    logger.debug "request.host=#{request.host}"
    
    if request.host != maindomain && request.host != 'localhost' && request.host !~ /^\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}$/
      location = Location.find_by_domain(request.host)
      unless location.nil?
        redirect_to URI.encode(myhost(location.name))
      else
        redirect_to URI.encode(myhost)
      end
    else
      @location = Location.find_by_name(params[:city_name]) unless params[:city_name].nil?
      @product = BusinessDeal.find_by_name(params[:product_kind]) unless params[:product_kind].nil?
      @service = BusinessDeal.find_by_name(params[:service_kind]) unless params[:service_kind].nil?
      
      # выдаёт весь каталог
      if @location == nil && @product == nil && @service == nil
        @locations = Location.all
        @products = BusinessDeal.find_all_by_kind t('business_deal.product')
        @services = BusinessDeal.find_all_by_kind t('business_deal.service')
        # @catalogs = Catalog.all(:limit => 4, :order => 'id DESC')
        @catalogs = Catalog.find_by_sql("SELECT * FROM catalogs WHERE tariff != 'free' ORDER BY id DESC LIMIT 4 ")
      end
      # поиск только по городу
      if @location != nil && @product == nil && @service == nil
        @locations = Location.all
        @products = products_only_this_location(@location)
        @services = services_only_this_location(@location)
        # @catalogs = Catalog.find_all_by_location_id( @location.id, :limit => 4, :order => 'id DESC' )
        @catalogs = Catalog.find_by_sql("SELECT * FROM catalogs WHERE tariff != 'free' AND location_id = '#{@location.id}' ORDER BY id DESC LIMIT 4 ")
      end
      # посик по городу и товару - отобразить все каталоги по городу с товаром
      if @location != nil && @product != nil && @service == nil
        @locations = Location.all
        @products = products_only_this_location(@location)
        @services = services_only_this_location(@location)
        @catalogs = catalogs_only_this_location_and_deal(@location, @product)
      end
      # поиск по городу и услуге - отобразить все каталоги по городу с услугой
      if @location != nil && @product == nil && @service != nil
        @locations = Location.all
        @products = products_only_this_location(@location)
        @services = services_only_this_location(@location)
        @catalogs = catalogs_only_this_location_and_deal(@location, @service)
      end
      # поиск только по товару - отобразить все каталоги с данным товаром
      if @location == nil && @product != nil && @service == nil
        @locations = location_only_this_deal(@product)
        @products = BusinessDeal.find_all_by_kind t('business_deal.product')
        @services = services_only_this_product(@product)
        @catalogs = catalogs_only_this_deal(@product)
      end
      # поиск только по услуге - отобразить все каталоги с данной услугой
      if @location == nil && @product == nil && @service != nil
        @locations = location_only_this_deal(@service)
        @products = products_only_this_service(@service)
        @services = BusinessDeal.find_all_by_kind t('business_deal.service')
        @catalogs = catalogs_only_this_deal(@service)
      end
      if @location == nil && @product != nil && @service != nil
      end
      if @location != nil && @product != nil && @service != nil
      end
      
      @catalogs = free_tariff_in_end_catalogs(@catalogs)
      if @catalogs.nil?
        redirect_to root_url, :notice =>  t('messages.nothing')
      end

    end
    
  end
  
  def indexload
    @header_layout = 'catalogs/header'
    @body_css_class = "home"

    sql = ""
    if params[:catalog_ids] != ""
      params[:catalog_ids].each do |catalog_id| 
        sql = " id != #{catalog_id} AND" + sql
      end
      sql.gsub!(/^\ /, 'SELECT `catalogs`.* FROM `catalogs` WHERE ( ' )
      if params[:location_id] != 'null'
        location = Location.find(params[:location_id])
        sql.gsub!(/\ AND$/,") AND location_id = '#{location.id}' ORDER BY id DESC")
      else
        sql.gsub!(/\ AND$/,") ORDER BY id DESC")
      end

      @catalogs = Catalog.find_by_sql(sql)
      
      
      if params[:product_kind] != "null" || params[:service_kind] != "null"
        service_or_product_kind = params[:product_kind] if params[:product_kind] != "null"
        service_or_product_kind = params[:service_kind] if params[:service_kind] != "null"
        result = Array.new
        @catalogs.each do |catalog|
          unless catalog.business_deals.nil?
            catalog.business_deals.each do |deal|
              if "#{deal}" == "#{service_or_product_kind}"
                result << catalog
                break
              end
            end
          end
        end
        @catalogs = result
      end
      
      if params[:product_kind] != "null" && params[:service_kind] != "null"
        result = Array.new
        @catalogs.each do |catalog|
          unless catalog.business_deals.nil?
            catalog.business_deals.each do |deal|
              if "#{deal}" == "#{params[:product_kind]}"
                result << catalog
                break
              end
            end
          end
        end
        @catalogs.each do |catalog|
          unless catalog.business_deals.nil?
            catalog.business_deals.each do |deal|
              if "#{deal}" == "#{params[:service_kind]}"
                result << catalog
                break
              end
            end
          end
        end
        @catalogs = result
      end
      
      if params[:locations] != "null"
        locations = params[:locations].split(',')
        result = Array.new
        @catalogs.each do |catalog|
          locations.each do |location_id|
            if "#{catalog.location_id}" == "#{location_id}"
              result << catalog
              break
            end
          end
        end
        @catalogs = result
      end
      
      if params[:deal_ids] != "null"
        @deal_ids = params[:deal_ids].split(',')
        @catalogs = catalogs_only_these_deals(@deal_ids, @catalogs)
      end
      
      unless cookies[:izbrannoe].nil?
        @izbrannoe = Izbrannoe.find_all_by_identificator(cookies[:izbrannoe])
      end
      
      #logger.debug "@catalogs.size=#{@catalogs.size} params[:catalog_ids].size=#{params[:catalog_ids].size}"
      
      @catalogs = free_tariff_in_end_catalogs(@catalogs)
      @catalogs = truncate_array_of_catalogs(@catalogs)
      render 'index', :layout => false
    else
      render :nothing => true
    end
    
  end

  
  # GET /catalogs/1
  # GET /catalogs/1.xml
  def show
    unless params[:shortcut_name].nil?
      @catalog = Catalog.find_by_shortcut_name(params[:shortcut_name])
    else
      @catalog = Catalog.find(params[:id])
    end
    if @catalog
	@pictures = @catalog.pictures.all(:order => "id DESC")
      if !current_user.nil? && current_user.id == @catalog.user_id
        @picture = current_user.pictures.new
        @picture.user_id = current_user.id
        @picture.catalog_id = @catalog.id
        @all_business_deals = BusinessDeal.all
      end
      if !current_user.nil? && /admin/ =~ current_user.group
        @picture = Picture.new
        @picture.user_id = @catalog.user_id
        @picture.catalog_id = @catalog.id
        @all_business_deals = BusinessDeal.all
      end
    else
      redirect_to root_path, :alert => t('messages.catalogs_not_found')
    end

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @catalog }
    #end
    
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, :alert => t('messages.catalog_not_found')
  end

  # GET /catalogs/new
  # GET /catalogs/new.xml
  def new
    @catalog = Catalog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catalog }
    end
  end

  # GET /catalogs/1/edit
  def edit
    @catalog = Catalog.find(params[:id])
  end

  # POST /catalogs
  # POST /catalogs.xml
  def create
    @catalog = Catalog.new(params[:catalog])

    respond_to do |format|
      if @catalog.save
        format.html { redirect_to(@catalog, :notice => 'Catalog was successfully created.') }
        format.xml  { render :xml => @catalog, :status => :created, :location => @catalog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catalog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catalogs/1
  # PUT /catalogs/1.xml
  def update
    @catalog = Catalog.find(params[:id])
    business_deals = params[:business_deals]
    unless business_deals.nil?
      business_deal_ids = Array.new
      business_deals.each_key do |key|
        business_deal_ids << key if key != "0"
      end
      @catalog.business_deals = business_deal_ids
    end

    respond_to do |format|
      if @catalog.update_attributes(params[:catalog])
        format.html { redirect_to(@catalog, :notice => 'Catalog was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catalog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogs/1
  # DELETE /catalogs/1.xml
  def destroy
    if !current_user.nil? && /admin/ =~ current_user.group
      @catalog = Catalog.find(params[:id])
    else
      @catalog = current_user.catalogs.find(params[:id])
    end
    @catalog.destroy

    respond_to do |format|
      format.html { redirect_to(catalogs_url) }
      format.xml  { head :ok }
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end
  
  def loadmap
    @onload = 'init()'
    @pic = Picture.find(params[:id])
    @catalog = Catalog.find(@pic.catalog_id)
    render 'map_picture', :layout => true
  end
  
  def setcoordinate
    @catalog = Catalog.find(params[:id])
    @catalog.lat = params[:latitude]
    @catalog.lng = params[:longitude]
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    if @catalog.save
      render :text => "true"
    else
      render :text => "false"
    end
    rescue
      render :text => "false"
  end

  def mappopup
    @catalog = Catalog.find(params[:id])
    @pic = @catalog.pictures.first
    @business = BusinessType.find(@catalog.businesstype_id).name
    title = "<img src='#{@pic.picture.url(:small)}'><br><a href='#{shortcut_catalog_path(@catalog.shortcut_name)}' >#{@catalog.company_name}</a>"
    buffer = "point\ttitle\tdescription\ticon\ticonSize\n#{@catalog.lat}, #{@catalog.lng}\t#{title}\t<strong style='text-align: center'>#{@business}</strong>\t/images/map_marker_green.png\t24,40\n"
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    render :text => buffer, :layout => false
  end
  
  def search
    @body_css_class = "perma cities"
    @locations = Location.all
    @products = BusinessDeal.find_all_by_kind t('business_deal.product')
    @services = BusinessDeal.find_all_by_kind t('business_deal.services')
    @cols = 3
    @products_in_col = (@products.size.to_f/@cols).ceil - 1
    @services_in_col = (@services.size.to_f/@cols).ceil - 1
  end
  
  def myfind
    @header_layout = 'catalogs/header'
    @body_css_class = "home"
    
    if params[:products].empty? && params[:locations].empty?
      redirect_to root_url
    else
      unless params[:locations].empty?
        @location_ids = params[:locations].split(",")
        sql = ""
        @location_ids.each do |location_id|
          sql = " location_id = #{location_id} OR" + sql
        end
        sql.gsub!(/^\ /, 'SELECT `catalogs`.* FROM `catalogs` WHERE ( ' )
        sql.gsub!(/\ OR$/,") ORDER BY id DESC")
        @catalogs = Catalog.find_by_sql(sql)
        sql = ""
        @location_ids.each do |location_id|
          sql = " id = #{location_id} OR" + sql
        end
        sql.gsub!(/^\ /, 'SELECT `locations`.* FROM `locations` WHERE ( ' )
        sql.gsub!(/\ OR$/,") ORDER BY id DESC")
        @locations = Location.find_by_sql(sql)
        @location = @locations[0] if @locations.size == 1
        @products = products_only_these_locations(@locations, @catalogs)
        @services = services_only_this_locations(@locations, @catalogs)
        
        unless params[:products].empty?
          @deal_ids = params[:products].split(",")
          @catalogs = catalogs_only_these_deals(@deal_ids, @catalogs)
        end
      else
        @locations = Location.all
        @catalogs = Catalog.all
        @products = products_only_these_locations(@locations, @catalogs)
        @services = services_only_this_locations(@locations, @catalogs)
        unless params[:products].empty?
          @deal_ids = params[:products].split(",")
          @catalogs = catalogs_only_these_deals(@deal_ids, @catalogs)
        end
      end
      
      @catalogs = free_tariff_in_end_catalogs(@catalogs)
      @catalogs = truncate_array_of_catalogs(@catalogs)
      render 'index', :layout => true
    end
  end
  
private

  def truncate_array_of_catalogs(catalogs_array)
    result = Array.new
    if catalogs_array.size > 4
      for i in 0..3 do
        result << catalogs_array[i]
      end
    else
      result = catalogs_array
    end
    return result
  end

  def products_only_this_location(location)
    result = Array.new
    products = BusinessDeal.where( "kind = '#{t('business_deal.product')}'" )
    catalogs = Catalog.find_all_by_location_id( location.id )
    products.each do |product|
      catalogs.each do |catalog|
        flag = false
        unless catalog.business_deals.nil?
          catalog.business_deals.each do |deal|
            if "#{deal}" == "#{product.id}"
              result << product
              flag = true
              break
            end
          end
        end
        break if flag == true
      end
    end
    return result
  end

  def products_only_these_locations(locations, catalogs)
    result = Array.new
    business_deals = BusinessDeal.all
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        locations.each do |location|
          catalog.business_deals.each do |deal|
            if catalog.location_id == location.id
              business_deals.each do |bd|
                if "#{bd.id}" == "#{deal}" && bd.kind == t('business_deal.product')
                  result << bd
                  break
                end
              end
            end
          end
        end
      end
    end
    result.uniq!
    return result
  end
  
  def services_only_this_locations(locations, catalogs)
    result = Array.new
    business_deals = BusinessDeal.all
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        locations.each do |location|
          catalog.business_deals.each do |deal|
            if catalog.location_id == location.id
              business_deals.each do |bd|
                if "#{bd.id}" == "#{deal}" && bd.kind == t('business_deal.service')
                  result << bd
                  break
                end
              end
            end
          end
        end
      end
    end
    return result
  end

  def catalogs_only_these_deals(deal_ids, catalogs)
    result = Array.new
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        catalog.business_deals.each do |deal_id_in_catalog|
          deal_ids.each do |deal_id|
            # logger.debug "#{catalog.company_name} #{deal_id_in_catalog} #{deal_id}"
            if deal_id == deal_id_in_catalog
              result << catalog
              break
            end
          end
        end
      end
    end
    return result
  end

  def services_only_this_location(location)
    result = Array.new
    products = BusinessDeal.where( "kind = '#{t('business_deal.service')}'" )
    catalogs = Catalog.find_all_by_location_id( location.id )
    products.each do |product|
      catalogs.each do |catalog|
        flag = false
        unless catalog.business_deals.nil?
          catalog.business_deals.each do |deal|
            if "#{deal}" == "#{product.id}"
              result << product
              flag = true
              break
            end
          end
        end
        break if flag
      end
    end
    return result
  end
  
  def catalogs_only_this_location_and_deal(location, product)
    result = Array.new
    catalogs = Catalog.find_all_by_location_id( location.id )
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        catalog.business_deals.each do |deal|
          if "#{deal}" == "#{product.id}"
            result << catalog
            break
          end
        end
      end
    end
    return result
  end
  
  def location_only_this_deal(product)
    result = Array.new
    catalogs = Catalog.all
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        catalog.business_deals.each do |deal|
          if "#{deal}" == "#{product.id}"
            result << Location.find(catalog.location_id)
          end
        end
      end 
    end
    result.uniq!
    return result
  end
  
  def catalogs_only_this_deal(product)
    result = Array.new
    catalogs = Catalog.all
    catalogs.each do |catalog|
      unless catalog.business_deals.nil?
        catalog.business_deals.each do |deal|
          if "#{deal}" == "#{product.id}"
            result << catalog
          end
        end
      end 
    end
    return result
  end
  
  def services_only_this_product(product)
    result = BusinessDeal.find_all_by_kind( t('business_deal.service') )
    return result
  end
  
  def products_only_this_service(service)
    result = BusinessDeal.find_all_by_kind( t('business_deal.product') )
    return result
  end

  def free_tariff_in_end_catalogs(catalogs)
    payd_catalogs = Array.new
    free_catalogs = Array.new
    catalogs.each do |catalog|
      if catalog.tariff =~ /free/
        free_catalogs << catalog
      else
        payd_catalogs << catalog
      end
    end
    payd_catalogs.randomize!
    free_catalogs.randomize!
    result = payd_catalogs + free_catalogs
    return result
  end

end
