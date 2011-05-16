class AddRememberMeSaltToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :remember_me_token, :string
  end

  def self.down
    remove_column :users, :remember_me_token
  end
end
