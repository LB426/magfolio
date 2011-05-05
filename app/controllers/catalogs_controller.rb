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
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @catalogs }
    #end
    
    logger.debug "request.domain=#{request.domain}"
    logger.debug "request.fullpath=#{request.fullpath}"
    logger.debug "request.url=#{request.url}"
    logger.debug "request.host=#{request.host}"
    
    if request.host != maindomain && request.host != 'localhost'
      location = Location.find_by_domain(request.host)
      unless location.nil?
        redirect_to URI.encode(myhost(location.name))
      else
        redirect_to URI.encode(myhost)
      end
    else
      @location = Location.find_by_name(params[:city_name]) unless params[:city_name].nil?
      unless @location.nil?
        @locations = Location.where( "name != ?", @location.name )
        @catalogs = Catalog.find_all_by_location_id( @location.id, :limit => 4, :order => 'id DESC' )
      else
        @locations = Location.all
        @catalogs = Catalog.all(:limit => 4, :order => 'id DESC')
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
        sql.gsub!(/\ AND$/,") AND location_id = '#{location.id}' ORDER BY id DESC LIMIT 4")
      else
        sql.gsub!(/\ AND$/,") ORDER BY id DESC LIMIT 4")
      end
      @catalogs = Catalog.find_by_sql(sql)
      unless cookies[:izbrannoe].nil?
        @izbrannoe = Izbrannoe.find_all_by_identificator(cookies[:izbrannoe])
      end
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
      redirect_to root_path, :alert => "Таких каталогов нет!"
    end

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml  { render :xml => @catalog }
    #end
    
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, :alert => "Каталог не найден!"
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
        business_deal_ids << key
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
    @pic = Picture.find(params[:id])
    @catalog = Catalog.find(@pic.catalog_id)
    render 'map_picture', :layout => true
  end

end
