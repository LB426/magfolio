module OrdersHelper
  
  def delivery
    order_options = @cart.order_options
    unless order_options.nil?
      delivery = order_options['delivery']
      unless delivery.nil?
        return delivery
      end
    end
    t('order.msg_delivery_nothing')
  end
  
  def payment
    order_options = @cart.order_options
    unless order_options.nil? 
      payment = order_options['payment']
      unless payment.nil?
        return payment
      end
    end
    t('order.msg_payment_nothing')
  end
  
  def order_state(order = nil)
    case order.state
    when 'open'
      return t('order.state_open')
    when 'close'
      return t('order.state_close')
    else
      return 'state not defined'
    end
    'end of function'
  end
  
  def order_sum(order = nil)
    itogo_summa = 0
    order.products.each do |product|
      itogo_summa += product['price'].to_i
    end
    itogo_summa
  end
  
  def order_amount(order = nil)
    itogo_amount = 0
    order.products.each do |product|
      itogo_amount += product['amount'].to_i
    end
    itogo_amount
  end
  
  def order_state_color(order = nil)
    case order.state
    when 'open'
      return 'background-color:#00FA9A;color:#000000;'
    when 'close'
      return 'background-color:#000000;color:#FFFFFF;'
    else
      return 'state not defined'
    end
    'background-color:#000000;'
  end
  
end
