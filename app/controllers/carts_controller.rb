class CartsController < ApplicationController

  # GET /carts/1
  # GET /carts/1.xml
  def show
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
    else
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
    end
  end

  # GET /carts/1/edit
  def edit_products
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
      @cart.change_product_amount(params[:catalog_id],params[:product_id],params[:new_amount])
      if @cart.save
        render :text => true
      else
        render :text => false
      end
    else
      render :text => false
    end
  end
  
  def edit_delivery_order_options
    @cart == find_cart
    if @cart == nil
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
      return false
    end

    case params[:delivery]
    when 'samovyvoz'
      order_options = @cart.order_options
      order_options = {} if order_options.nil?
      order_options['delivery'] = t('order.delivery_samovyvoz')
      @cart.order_options = order_options
      @cart.save
      redirect_to make_order_path('2')
    else    
      redirect_to make_order_path('1'), :alert =>  t('order.msg_delivery_error')
    end
    
    rescue 
      msg = "#{t("default.rescue_error_in_controllers")} CartsController: #{$!}"
      redirect_to root_url, :alert => msg    
  end
  
  def edit_payment_order_options
    @cart == find_cart
    if @cart == nil
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
      return false
    end

    case params[:payment]
    when 'cash'
      order_options = @cart.order_options
      order_options = {} if order_options.nil?
      order_options['payment'] = t('order.payment_cash_obtaining')
      @cart.order_options = order_options
      @cart.save
      redirect_to make_order_path('3')
    else    
      redirect_to make_order_path('2'), :alert =>  t('order.msg_payment_error')
    end
    
    #rescue 
    #  msg = "#{t("default.rescue_error_in_controllers")} CartsController: #{$!}"
    #  redirect_to root_url, :alert => msg
  end

  # POST /carts
  # POST /carts.xml
  def add
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
      unless @cart.nil?
        @cart.add_product_to_products(params[:catalog_id], params[:product_id])
        if @cart.save
          render :text => {:cart => { 'result' => true, 'cart_unique_id' => @cart.unique_identifier, 'products_count' => @cart.products_count(params[:catalog_id]), 'product_count' => @cart.product_count(params[:catalog_id],params[:product_id])}}.to_json()
        else
          render :text => {'result' => false }.to_json()
        end
      else
        render :text => {'result' => false }.to_json()
      end
    else
      @cart = Cart.new()
      # @cart.catalog_id = params[:catalog_id]
      @cart.unique_identifier = BCrypt::Engine.hash_secret("#{@cart.id}", BCrypt::Engine.generate_salt)
      @cart.add_product_to_products(params[:catalog_id], params[:product_id])
      if @cart.save
        # render :text => {:cart => {'result' => true, 'cart_unique_id' => @cart.unique_identifier }}.to_json()
        render :text => {:cart => { 'result' => true, 'cart_unique_id' => @cart.unique_identifier, 'products_count' => @cart.products_count(params[:catalog_id]), 'product_count' => @cart.product_count(params[:catalog_id],params[:product_id])}}.to_json()
      else
        render :text => {'result' => false }.to_json()
      end
    end
  end
  
  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy_from_cart
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
      @cart.delete_product(params[:catalog_id],params[:product_id])
      if @cart.save
        if @cart.products.size == 1
          products = @cart.products[0]
          if products[:products_count] == 0
            @cart.destroy
            cookies.delete(:cart)
            redirect_to root_url, :alert =>  t('cart.msg_cart_destroyed_no_products')
          else
            redirect_to show_mycart_path, :notice =>  t('cart.msg_del_prod')
          end
        else
          redirect_to show_mycart_path, :notice =>  t('cart.msg_del_prod')
        end
      else
        redirect_to show_mycart_path, :alert =>  t('cart.msg_no_del_prod')
      end
    else
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
    end
  end
  
  def destroy
    unless cookies[:cart].nil?
      @cart = Cart.find_by_unique_identifier(cookies[:cart])
      @cart.destroy
      cookies.delete(:cart)
      redirect_to root_url, :alert =>  t('cart.msg_cart_destroyed')
    else
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
    end
  end
  
end
