class AddLogotypeToSignup < ActiveRecord::Migration
  def self.up
    add_column :signups, :logo_file_name,    :string
    add_column :signups, :logo_content_type, :string
    add_column :signups, :logo_file_size,    :integer
    add_column :signups, :logo_updated_at,   :datetime
  end

  def self.down
    remove_column :signups, :logo_file_name,    :string
    remove_column :signups, :logo_content_type, :string
    remove_column :signups, :logo_file_size,    :integer
    remove_column :signups, :logo_updated_at,   :datetime
  end
end
