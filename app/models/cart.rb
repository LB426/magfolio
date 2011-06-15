class Cart < ActiveRecord::Base
  serialize :products

  # product - это хэш из каталог_ID и product_ID
  def add_product_to_products(catalog_id, product_id)
    logger.debug "1 catalog_id=#{catalog_id} product_id=#{product_id}"
    if self.products == nil
      self.products = [{:catalog_id => catalog_id, 
                        :product_ids => [{:product_id => product_id, :product_count => 1}],
                        :products_count => 1}]
    else
      self.products.each do |products|
        if products[:catalog_id].to_i == catalog_id.to_i
          flag = true
          products[:product_ids].each do |product|
            logger.debug "2 product=#{product}"
            if product[:product_id].to_i == product_id.to_i
              product[:product_count] = product[:product_count] + 1
              products[:products_count] = products[:products_count] + 1
              flag = false
              break
            end
          end
          if flag
            products[:product_ids] << {:product_id => product_id, :product_count => 1}
            products[:products_count] = products[:products_count] + 1
          end
        end
      end
    end
  end
  
  def products_count(catalog_id)
    self.products.each do |products|
      if products[:catalog_id].to_i == catalog_id.to_i
        return products[:products_count]
      end
    end
    return 0
  end
  
  def product_count(catalog_id, product_id)
    self.products.each do |products|
      if products[:catalog_id].to_i == catalog_id.to_i
        products[:product_ids].each do |product|
          if product[:product_id].to_i == product_id.to_i
            return product[:product_count]
          end
        end
      end
    end
    return 0
  end
  
  def all_products_count
    count = 0
    self.products.each do |products|
      count = count.to_i + products[:products_count].to_i
    end
    count
  end
  
  def change_product_amount(catalog_id, product_id, amount)
    if amount.to_i == 0
      self.delete_product(catalog_id, product_id)
    else
      self.products.each do |products|
        if products[:catalog_id].to_i == catalog_id.to_i
          products[:product_ids].each do |product|
            if product[:product_id].to_i == product_id.to_i
              products[:products_count] = products[:products_count] - product[:product_count]
              product[:product_count] = amount.to_i
              products[:products_count] = products[:products_count] + product[:product_count]
            end
          end
        end
      end
    end
  end
  
  def delete_product(catalog_id, product_id)
    p_index = -1
    self.products.each do |products|
      if products[:catalog_id].to_i == catalog_id.to_i
        products[:product_ids].each_index do |i|
          product = products[:product_ids][i]
          if product[:product_id].to_i == product_id.to_i
            p_index = i
            break
          end
        end
      end
      if p_index != -1
        product = products[:product_ids][p_index]
        products[:products_count] = products[:products_count] - product[:product_count]
        products[:product_ids].delete_at(p_index)
        break
      end
    end  
  end
  
end
