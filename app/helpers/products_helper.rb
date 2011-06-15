module ProductsHelper
  def product_in_carts?(catalog_id, product_id)
    unless cookies[:cart].nil?
      cart = Cart.find_by_unique_identifier(cookies[:cart])
      return "#{t('product.in_cart')}(#{cart.product_count(catalog_id, product_id)})"
    end   
    t('product.pay')
  end
  
  def all_in_carts?(catalog_id)
    unless cookies[:cart].nil?
      cart = Cart.find_by_unique_identifier(cookies[:cart])
      return "(#{cart.products_count(catalog_id)})"
    end
    ""
  end
  
end
