class AddShortLinkToIzbrannoe < ActiveRecord::Migration
  def self.up
    add_column :izbrannoes, :link, :string
  end

  def self.down
    remove_column :izbrannoes, :link
  end
end
