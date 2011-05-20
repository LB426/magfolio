class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @catalog = Catalog.find(params[:catalog_id])
    @products = @catalog.products
    if current_user
      @product = @catalog.products.new
      @product.user_id = @catalog.user_id
    end
    case @catalog.zakaz_layout
    when /bouquet of flowers/
      @body_css_class = "home favorites"
      render 'bouquet_of_flowers', :layout => true
    else
      
      render 'zakaz_phone', :layout => true
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.find(params[:id])
    case @catalog.zakaz_layout
    when /bouquet of flowers/
      render 'edit_bouquet_of_flowers', :layout => false
    else
      redirect_to root_url, :alert => 'нет обработчика редактирования для такого типа товаров'
    end
  end

  # POST /products
  # POST /products.xml
  def create
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(catalog_products_path(@catalog), :notice => 'Товар был успешно добавлен') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(catalog_products_path(@catalog), :notice => 'Ценик был успешно изменён.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(catalog_products_path(@catalog)) }
      format.xml  { head :ok }
    end
  end
end
