class CreateBusinessTypes < ActiveRecord::Migration
  def self.up
    create_table :business_types do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :business_types, :id
  end

  def self.down
    drop_table :business_types
  end
end
