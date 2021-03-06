class Signup < ActiveRecord::Base
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/signups/logos/:id/:style/:basename.:extension",
                    :url  => "/assets/signups/logos/:id/:style/:basename.:extension"
                    
  has_attached_file :bestpicture, 
                    :styles => { :small => "195x136#", :medium => "430x300#", :large => "897x628#" },
                    :path => ":rails_root/public/assets/signups/pictures/:id/:style/:basename.:extension",
                    :url  => "/assets/signups/pictures/:id/:style/:basename.:extension"
  
  before_create :randomize_file_name
  
  serialize :business_deals
  
private

  def randomize_file_name
    unless bestpicture_file_name.nil?
      extension = File.extname(bestpicture_file_name).downcase
      self.bestpicture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
    unless logo_file_name.nil?
      extension = File.extname(logo_file_name).downcase
      self.logo.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end  

end
