class ChgOrderStateInOrdersModel < ActiveRecord::Migration
  def self.up
    remove_column :orders, :state
    add_column :orders, :state, :text, :null => false
  end

  def self.down
    remove_column :orders, :state
    add_column :orders, :state, :string, :default => 'open', :null => false
  end
end
