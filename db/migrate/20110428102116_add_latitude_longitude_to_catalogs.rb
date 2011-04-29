class AddLatitudeLongitudeToCatalogs < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :lat, :string
    add_column :catalogs, :lng, :string
  end

  def self.down
    remove_column :catalogs, :lat
    remove_column :catalogs, :lng
  end
end
