class Catalog < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/logos/:id/:style/:basename.:extension",
                    :url  => "/assets/logos/:id/:style/:basename.:extension"
end
