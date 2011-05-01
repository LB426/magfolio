class AddUserKleveradminToAdminGroup < ActiveRecord::Migration
  def self.up
    user = User.find_by_email('klever-admin@mydomain.tld')
    user.group = 'admin'
    user.save
  end

  def self.down
  end
end
