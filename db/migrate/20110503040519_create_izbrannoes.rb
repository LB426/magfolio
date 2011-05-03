class CreateIzbrannoes < ActiveRecord::Migration
  def self.up
    create_table :izbrannoes do |t|
      t.string :identificator
      t.integer :catalog_id

      t.timestamps
    end
  end

  def self.down
    drop_table :izbrannoes
  end
end
