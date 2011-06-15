class AddProductsFieldToCartModel < ActiveRecord::Migration
  def self.up
    add_column :carts, :products, :text
  end

  def self.down
    remove_column :carts, :products
  end
end
