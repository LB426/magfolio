class AddAddressToCatalogs < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :address, :string
  end

  def self.down
    remove_column :catalogs, :address
  end
end
