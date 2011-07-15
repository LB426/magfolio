class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @body_css_class = "orderstage3"
    @header_layout = 'orders/header_show'
    @order = Order.find_by_customer_id(params[:customer_id])
    @catalog = Catalog.find(@order.catalog_id)
    unless @order.nil?
    else
      redirect_to root_url, :alert =>  t('order.msg_orders_not_found')
    end
    
    rescue 
      msg = "#{t("default.rescue_error_in_controllers")} OrdersController: #{$!}"
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
        redirect_to show_order_path(customer_id), :notice =>  t('order.msg_order_create_success')
      else
        redirect_to root_url, :alert =>  t('order.msg_order_create_non_success')
      end
    else
      redirect_to root_url, :alert =>  t('order.msg_stage_not_found')
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
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
    
private

  def random_string(size = 32)
    chars = ('0'..'9').to_a
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end  
  
end
