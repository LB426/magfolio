class AddOrderStatusToCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :order_statuses, :text
    
  end

  def self.down
    remove_column :catalogs, :order_statuses
  end
end
