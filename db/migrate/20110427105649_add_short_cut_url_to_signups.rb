class AddShortCutUrlToSignups < ActiveRecord::Migration
  def self.up
    add_column :signups, :shortcut_url, :string
  end

  def self.down
    remove_column :signups, :shortcut_url
  end
end
