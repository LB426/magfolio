class AddDomainNameToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :vid, :string
    add_column :locations, :domain, :string
  end

  def self.down
    remove_column :locations, :vid
    remove_column :locations, :domain
  end
end
