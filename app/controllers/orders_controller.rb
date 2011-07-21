class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    @body_css_class = "home favorites"
    
    @customer_id = nil
    unless cookies[:customer].nil?
      @customer_id = cookies[:customer]
    else
      @customer_id = params[:customer_id]
      cookies[:customer] = @customer_id
    end
    @orders = Order.find_all_by_customer_id(@customer_id)
    
    rescue 
      msg = "#{t("default.rescue_error_in_controllers")} OrdersController.index: #{$!}"
      redirect_to root_url, :alert => msg
  end
  
  def customer_orders_for_catalog
    @customer_id = params[:customer_id]
    @orders = Order.find_all_by_customer_id_and_catalog_id(@customer_id, params[:catalog_id])
    @catalog = Catalog.find(params[:catalog_id])
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @body_css_class = "orderstage3"
    @header_layout = 'orders/header_show'
    #@order = Order.find_by_customer_id(params[:customer_id])
    @order = Order.find(params[:id])
    @catalog = Catalog.find(@order.catalog_id)
    unless @order.nil?
    else
      redirect_to root_url, :alert =>  t('order.msg_orders_not_found')
    end
    
    rescue 
      msg = "#{t("default.rescue_error_in_controllers")} OrdersController.show: #{$!}"
      redirect_to root_url, :alert => msg
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart == find_cart
    if @cart == nil
      redirect_to root_url, :alert =>  t('cart.msg_nothing')
      return false
    end
      
    case params[:stage]
    when "1"
      @body_css_class = "orderstage1"
      @header_layout = 'orders/header_stage1'
      render 'stage1', :layout => true
    when "2"
      @body_css_class = "orderstage2"
      @header_layout = 'orders/header_stage2'
      render 'stage2', :layout => true
    when "3"
      @body_css_class = "orderstage3"
      @header_layout = 'orders/header_stage3'
      render 'stage3', :layout => true
    when "4"
      flag = false
      customer_id = customer?
      if customer_id == nil
        # если новый покупатель, т.е.
        # у него не установленна кука customer
        # то генерим ID для нового покупателя по которому он сможет видеть свои заказы
        customer_id = random_string(10) 
        @cart.products.each do |products|
          @order = Order.new
          @order.catalog_id = products[:catalog_id].to_i
          @order.customer_id = customer_id
          # формируем массив с продуктами
          products_array = Array.new
          products[:product_ids].each do |product|
            price = product[:product_count].to_i * Product.find(product[:product_id]).price
            products_array << {'product_id' => product[:product_id].to_i, 'name' => Product.find(product[:product_id]).name, 'amount' => product[:product_count].to_i, 'price' => price }
          end
          @order.products = products_array
          @order.payment = { 'payd_system' => @cart.order_options['payment'] }
          @order.delivery = { 'method' => @cart.order_options['delivery'] }
          @order.state = [{'state'=>1, 'date'=>Time.now}]
          if @order.save          
            flag = true
          else
            flag = false
            break
          end
        end
      else
        # если есть другие неотработанные заказы
      end  
      
      # flag - говорит что заказ успешно/неуспешно сохранился в БД
      if flag
        cookies[:customer] = customer_id
        @cart.destroy
        cookies.delete(:cart)
        redirect_to show_order_path(customer_id, @order.id), :notice =>  t('order.msg_order_create_success')
      else
        redirect_to root_url, :alert =>  t('order.msg_order_create_non_success')
      end
    else
      redirect_to root_url, :alert =>  t('order.msg_stage_not_found')
    end
  end

  # GET /orders/1/edit
  def editstate 
    @order = Order.find(params[:id])
    @catalog = Catalog.find(@order.catalog_id)
    if params[:future_state] != '0'
      @order.state << {'state' => params[:future_state].to_i, 'date'=>Time.now}
      @order.save
    end
    arr = Array.new
    for i in 0..@order.state.size-1 do
      # state_to_string(@order.state[i]['state'])
      arr[i] = {
                  'state_name' => state_to_string(@order.state[i]['state'].to_i),
                  'state_val' => @order.state[i]['state'],
                  'date' => Russian::strftime(@order.state[i]['date'], "%d.%m.%Y %H:%M") 
               }
    end
    
    response.headers['Content-type'] = "text/plain; charset=utf-8"
    render :text => arr.to_json
    
    #response.headers['Content-type'] = "text/html; charset=utf-8"
    #render 'orders/_order_state', :layout => false
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
    
  def catalog_orders
    @catalog = Catalog.find(params[:catalog_id])
    if current_user_self?
      @orders = Order.find_all_by_catalog_id(@catalog.id, :order => 'id DESC')
    else
      redirect_to root_url, :alert =>  t('default.you_not_owner_directory')
    end
  end
  
  def catalog_order
    @body_css_class = "orderstage3"
    @header_layout = 'orders/header_show'
    @order = Order.find(params[:id])
    @catalog = Catalog.find(@order.catalog_id)
    if current_user_self?
      
    else
      redirect_to root_url, :alert =>  t('default.you_not_owner_directory')
    end
  end
  
private

  def random_string(size = 32)
    chars = ('0'..'9').to_a
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end  
  
end
