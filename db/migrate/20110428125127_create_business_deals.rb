class CreateBusinessDeals < ActiveRecord::Migration
  def self.up
    create_table :business_deals do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :business_deals
  end
end
