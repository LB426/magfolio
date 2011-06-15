class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :catalog_id
      t.integer :order_id

      t.timestamps
    end
    
    add_index :carts, :id
    add_index :carts, :catalog_id
    add_index :carts, :order_id
  end

  def self.down
    drop_table :carts
  end
end
