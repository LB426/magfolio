class Signup < ActiveRecord::Base
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/signups/logos/:id/:style/:basename.:extension",
                    :url  => "/assets/signups/logos/:id/:style/:basename.:extension"
                    
  has_attached_file :bestpicture, 
                    :styles => { :small => "195x136#", :medium => "430x300#", :large => "897x628#" },
                    :path => ":rails_root/public/assets/signups/pictures/:id/:style/:basename.:extension",
                    :url  => "/assets/signups/pictures/:id/:style/:basename.:extension"
end
