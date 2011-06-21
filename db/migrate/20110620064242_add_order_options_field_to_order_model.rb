class AddOrderOptionsFieldToOrderModel < ActiveRecord::Migration
  def self.up
    remove_column :carts, :order_id
    remove_column :orders, :catalog_id
    add_column :orders, :catalog_id, :integer, :null => false
    add_column :orders, :customer_id, :string, :null => false
    add_column :orders, :products, :text, :null => false
    add_column :orders, :payment, :text, :null => false
    add_column :orders, :delivery, :text, :null => false
    add_column :orders, :state, :string, :default => 'open', :null => false
    
    add_index :orders, :id
    add_index :orders, :catalog_id
    add_index :orders, :customer_id
  end

  def self.down
    remove_index :orders, :customer_id
    remove_index :orders, :catalog_id
    remove_index :orders, :id
    remove_column :orders, :state
    remove_column :orders, :delivery
    remove_column :orders, :payment
    remove_column :orders, :products
    remove_column :orders, :customer_id
    remove_column :orders, :catalog_id
    add_column :orders, :catalog_id, :integer
    add_column :carts, :order_id, :integer
  end
end
