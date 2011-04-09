class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.string  :session_id
      t.string  :bestpic_comment
      t.string  :company_name
      t.integer :businesstype_id
      t.integer :location_id
      t.string  :phone
      t.string  :email
      t.string  :company_url
      t.string  :tariff
      
      t.timestamps
    end
    
    add_index :signups, :id
    add_index :signups, :session_id
  end

  def self.down
    drop_table :signups
  end
end
