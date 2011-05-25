class ProductPicturesController < ApplicationController
  before_filter :logged_in?
  
  # GET /product_pictures
  # GET /product_pictures.xml
  def index
    @product_pictures = ProductPicture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_pictures }
    end
  end

  # GET /product_pictures/1
  # GET /product_pictures/1.xml
  def show
    @product_picture = ProductPicture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_picture }
    end
  end

  # GET /product_pictures/new
  # GET /product_pictures/new.xml
  def new
    @product_picture = ProductPicture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_picture }
    end
  end

  # GET /product_pictures/1/edit
  def edit
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.find(params[:product_id])
    @product_picture = ProductPicture.find(params[:id])
    render :layout => false
  end

  # POST /product_pictures
  # POST /product_pictures.xml
  def create
    @product_picture = ProductPicture.new(params[:product_picture])

    respond_to do |format|
      if @product_picture.save
        format.html { redirect_to(@product_picture, :notice => 'Product picture was successfully created.') }
        format.xml  { render :xml => @product_picture, :status => :created, :location => @product_picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_pictures/1
  # PUT /product_pictures/1.xml
  def update
    @catalog = Catalog.find(params[:catalog_id])
    @product_picture = ProductPicture.find(params[:id])

    respond_to do |format|
      if @product_picture.update_attributes(params[:product_picture])
        format.html { redirect_to(catalog_products_path(@catalog), :notice => 'Product picture was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(catalog_products_path(@catalog), :alert => 'ERROR Product picture updated.') }
        format.xml  { render :xml => @product_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_pictures/1
  # DELETE /product_pictures/1.xml
  def destroy
    @catalog = Catalog.find(params[:catalog_id])
    @product_picture = ProductPicture.find(params[:id])
    @product_picture.destroy

    redirect_to catalog_products_path(@catalog)
  end
end
