class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog
  
  has_attached_file :picture, 
                    :styles => { :small => "195x136#", :medium => "430x300#", :large => "897x628#" },
                    :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension",
                    :url  => "/assets/pictures/:id/:style/:basename.:extension"

  before_create :randomize_file_name

private

  def randomize_file_name
    unless picture_file_name.nil?
      extension = File.extname(picture_file_name).downcase
      self.picture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end

end
