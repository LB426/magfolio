class AddAdminUser < ActiveRecord::Migration
  def self.up
    new_user = {'user'=>{
                          'password'=>'x11!!unflux',
                          'email'=>'klever-admin@mydomain.tld'}}
    user = User.new(new_user['user'])
    user.save
  end

  def self.down
    user = User.find_by_email('klever-admin@mydomain.tld')
    user.destroy
  end
end
