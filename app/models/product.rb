class Product < ActiveRecord::Base
  belongs_to  :catalog
  belongs_to  :user
  has_many    :product_pictures, :dependent => :destroy
  
  accepts_nested_attributes_for :product_pictures
    
end
