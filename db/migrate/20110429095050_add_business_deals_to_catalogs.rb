class AddBusinessDealsToCatalogs < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :business_deals, :text
  end

  def self.down
    remove_column :catalogs, :business_deals
  end
end
