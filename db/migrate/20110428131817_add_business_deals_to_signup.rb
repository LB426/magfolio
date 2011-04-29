class AddBusinessDealsToSignup < ActiveRecord::Migration
  def self.up
    add_column :signups, :business_deals, :text
  end

  def self.down
    remove_column :signups, :business_deals
  end
end
