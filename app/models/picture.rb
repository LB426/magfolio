class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog
  
  has_attached_file :picture, 
                    :styles => { :small => ["195x136#", :jpg], :medium => ["430x300#", :jpg], :large => ["897x628#", :jpg] },
                    :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension",
                    :url  => "/assets/pictures/:id/:style/:basename.:extension",
                    :convert_options => { :large => "-quality 52", :medium => "-quality 52" }

  before_create :randomize_file_name

private

  def randomize_file_name
    unless picture_file_name.nil?
      extension = File.extname(picture_file_name).downcase
      self.picture.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end

end
