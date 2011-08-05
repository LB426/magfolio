class Catalog < ActiveRecord::Base
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :product_pictures, :through => :products, :dependent => :destroy
  
  has_attached_file :logo, 
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :path => ":rails_root/public/assets/logos/:id/:style/:basename.:extension",
                    :url  => "/assets/logos/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"

  before_create :randomize_file_name
  
  serialize :business_deals
  serialize :order_statuses
  serialize :filter_params
  
  after_save :show_filter_params

private

  def randomize_file_name
    unless logo_file_name.nil?
      extension = File.extname(logo_file_name).downcase
      self.logo.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
    end
  end
  
  def show_filter_params
    logger.debug "after_save :show_filter_params"
    unless self.filter_params.nil?
      logger.debug "self.filter_params[:status].size: #{self.filter_params[:status].size}"
      self.filter_params[:status].each do |key, val|
        logger.debug "self.filter_params[:status]['#{key}']=#{val}"
      end
    end
  end

end

