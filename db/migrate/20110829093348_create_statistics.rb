class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.integer :catalog_id
      t.integer :views_counter

      t.timestamps
    end
    
    add_index :statistics, :id
    add_index :statistics, :catalog_id
  end

  def self.down
    drop_table :statistics
  end
end
