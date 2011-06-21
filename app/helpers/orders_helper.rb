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
  
end
