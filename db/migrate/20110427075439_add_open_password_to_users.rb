class AddOpenPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :open_text_password, :string
  end

  def self.down
    remove_column :users, :open_text_password
  end
end
