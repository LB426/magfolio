class AddOrderOptionsFieldToCartModel < ActiveRecord::Migration
  def self.up
    add_column :carts, :order_options, :text
  end

  def self.down
    remove_column :carts, :order_options
  end
end
