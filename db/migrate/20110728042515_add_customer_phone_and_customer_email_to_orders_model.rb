class AddCustomerPhoneAndCustomerEmailToOrdersModel < ActiveRecord::Migration
  def self.up
    add_column :orders, :customer_phone, :string
    add_column :orders, :customer_email, :string
    add_column :orders, :agreement, :string
  end

  def self.down
    remove_column :orders, :agreement
    remove_column :orders, :customer_email
    remove_column :orders, :customer_phone
  end
end
