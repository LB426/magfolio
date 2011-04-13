class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog
  
  has_attached_file :picture, 
                    :styles => { :small => "195x136>", :medium => "430x300>" },
                    :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension",
                    :url  => "/assets/pictures/:id/:style/:basename.:extension"
end
