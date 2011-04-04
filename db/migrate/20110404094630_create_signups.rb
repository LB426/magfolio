class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.string :company_name
      t.string :business_type
      t.string :location
      t.string :phone
      t.string :email
      t.string :company_url
      
      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
