class CreateCatalogs < ActiveRecord::Migration
  def self.up
    create_table :catalogs do |t|
      t.integer   :user_id, :null => false
      t.string    :company_name, :null => false
      t.integer   :businesstype_id, :null => false
      t.integer   :location_id, :null => false
      t.string    :phone, :null => false
      t.string    :email, :null => false
      t.string    :company_url
      t.string    :tariff, :null => false
      t.integer   :rating, :null => false, :default => 0
      t.text      :company_description
      t.string    :logo_file_name
      t.string    :logo_content_type
      t.integer   :logo_file_size
      t.datetime  :logo_updated_at

      t.timestamps
    end
    
    add_index :catalogs, :id
    add_index :catalogs, :user_id
    add_index :catalogs, :businesstype_id
    add_index :catalogs, :location_id
  end

  def self.down
    drop_table :catalogs
  end
end
