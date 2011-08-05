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
  
  def last_order_state(order = nil)
    order.state[order.state.size-1]['state']
  end
  
  def last_order_state_date(order = nil)
    return Russian::strftime(order.state[order.state.size-1]['date'], "%d.%m.%Y %H:%M")
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
    color = ""
    color << 'background-color:'
    color << order.state[order.state.size - 1]['bgcolor']
    color << ';color:'
    color << order.state[order.state.size - 1]['color']
    color << ';'
    color
  end
  
  def archive?
    last_state = @order.state[@order.state.size - 1]['state']
    if last_state == t('order.state_transferred_to_archive')
      return true
    else
      return false
    end
  end
  
  def possible_statuses
    html = ""
    if current_user_self? && !archive?
      html << "<select id=\"change_state\">"
      for i in 0..@catalog.order_statuses.size-1 do
        html << "<option value=\"#{i}\">#{@catalog.order_statuses[i]['text']}</option>"
      end
      html << "</select>"
      html << "<a href=\"#add_comment_to_last_state_dialog\" id=\"add_comment_to_last_state_link\" title=\"#{t('order.statuses_select_title')}\">#{t('default.comment')}</a>"
    end
    html.html_safe
  end
  
  def statuse_filter
    html = ""
    @catalog.filter_params[:status].each do |key, val|
      html << '<div class="status_checkbox">'
      if val == true
        html << '<input name="statuses[' 
        html << key
        html << ']" type="checkbox" checked /></br>'
      else
        html << '<input name="statuses[' 
        html << key
        html << ']" type="checkbox" /></br>'
      end
      html << key
      html << '</div>'
    end
    html.html_safe  
  end
  
end
