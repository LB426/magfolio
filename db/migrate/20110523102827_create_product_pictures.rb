class CreateProductPictures < ActiveRecord::Migration
  def self.up
    create_table :product_pictures do |t|
      t.integer   :user_id, :null => false
      t.integer   :catalog_id, :null => false
      t.integer   :product_id, :null => false
      t.string    :note
      t.string    :picture_file_name
      t.string    :picture_content_type
      t.integer   :picture_file_size
      t.datetime  :picture_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :product_pictures
  end
end
