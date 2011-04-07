class BusinessTypesController < ApplicationController
  # GET /business_types
  # GET /business_types.xml
  def index
    @business_types = BusinessType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @business_types }
    end
  end

  # GET /business_types/1
  # GET /business_types/1.xml
  def show
    @business_type = BusinessType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @business_type }
    end
  end

  # GET /business_types/new
  # GET /business_types/new.xml
  def new
    @business_type = BusinessType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @business_type }
    end
  end

  # GET /business_types/1/edit
  def edit
    @business_type = BusinessType.find(params[:id])
  end

  # POST /business_types
  # POST /business_types.xml
  def create
    @business_type = BusinessType.new(params[:business_type])

    respond_to do |format|
      if @business_type.save
        format.html { redirect_to(@business_type, :notice => 'Business type was successfully created.') }
        format.xml  { render :xml => @business_type, :status => :created, :location => @business_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @business_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /business_types/1
  # PUT /business_types/1.xml
  def update
    @business_type = BusinessType.find(params[:id])

    respond_to do |format|
      if @business_type.update_attributes(params[:business_type])
        format.html { redirect_to(@business_type, :notice => 'Business type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @business_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /business_types/1
  # DELETE /business_types/1.xml
  def destroy
    @business_type = BusinessType.find(params[:id])
    @business_type.destroy

    respond_to do |format|
      format.html { redirect_to(business_types_url) }
      format.xml  { head :ok }
    end
  end
  
  def ajaxcreate
    @business_type = BusinessType.new(params[:business_type])
    @business_type.save
    render :nothing => true
  end
  
  def ajaxgetbusinesstype
    business_types = BusinessType.all
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    render :text => business_types.to_json(:only => [ :id, :name ])  
  end
  
end
