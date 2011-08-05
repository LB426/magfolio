class Order < ActiveRecord::Base
  serialize :products
  serialize :payment
  serialize :delivery
  serialize :state
  # validates_uniqueness_of :customer_identifer
  
  paginates_per 10
  
end

