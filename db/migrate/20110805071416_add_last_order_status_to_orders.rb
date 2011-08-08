class AddLastOrderStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :last_status, :string
    
    add_index :orders, :last_status
  end

  def self.down
    remove_index :orders, :last_status
    
    remove_column :orders, :last_status
  end
end
