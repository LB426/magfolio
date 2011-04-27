class AddShortCatalogNameToCatalogs < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :shortcut_name, :string
    add_index :catalogs, :shortcut_name
  end

  def self.down
    remove_column :catalogs, :shortcut_name
  end
end
