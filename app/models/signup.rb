class Signup < ActiveRecord::Base
  has_attached_file :logotype, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
