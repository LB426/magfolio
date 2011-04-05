class Signup < ActiveRecord::Base
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/logos/:id/:style/:basename.:extension"
end
