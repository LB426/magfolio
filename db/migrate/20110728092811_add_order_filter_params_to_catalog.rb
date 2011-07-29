class AddOrderFilterParamsToCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :filter_params, :text
  end

  def self.down
    remove_column :catalogs, :filter_params
  end
end
