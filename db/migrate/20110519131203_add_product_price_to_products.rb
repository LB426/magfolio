class AddProductPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :price_notation, :string
    add_column :products, :price, :integer
  end

  def self.down
    remove_column :products, :price_notation
    remove_column :products, :price
  end
end
