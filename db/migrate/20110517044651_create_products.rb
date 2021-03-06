class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :catalog_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
