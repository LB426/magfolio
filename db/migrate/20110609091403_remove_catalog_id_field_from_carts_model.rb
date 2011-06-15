class RemoveCatalogIdFieldFromCartsModel < ActiveRecord::Migration
  def self.up
    remove_column :carts, :catalog_id
  end

  def self.down
    add_column :carts, :catalog_id, :integer
  end
end
