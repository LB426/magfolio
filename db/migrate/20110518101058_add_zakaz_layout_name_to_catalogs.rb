class AddZakazLayoutNameToCatalogs < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :zakaz_layout, :string
  end

  def self.down
    remove_column :catalogs, :zakaz_layout
  end
end
