class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string  :name
      t.integer :country_id
      t.timestamps
    end
    
    add_index :locations, :id
    Location.create :name => 'Tihoretsk'
  end

  def self.down
    drop_table :locations
  end
end
