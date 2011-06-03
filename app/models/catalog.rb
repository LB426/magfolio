class Catalog < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :product_pictures, :through => :products, :dependent => :destroy
  
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/logos/:id/:style/:basename.:extension",
                    :url  => "/assets/logos/:id/:style/:basename.:extension"

  before_create :randomize_file_name
  
  serialize :business_deals

private

  def randomize_file_name
    unless logo_file_name.nil?
      extension = File.extname(logo_file_name).downcase
      self.logo.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end

end
