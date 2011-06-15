class AddUniqueNoNidIdentiferToCartModel < ActiveRecord::Migration
  def self.up
    add_column :carts, :unique_identifier, :string, :null => false
    add_index :carts, :unique_identifier
  end

  def self.down
    remove_column :carts, :unique_identifier
  end
end
