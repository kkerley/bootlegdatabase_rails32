class Venue < ActiveRecord::Base
  versioned
  
  require 'paperclip'
  belongs_to :address
  has_many :performances
  
  before_create :create_permalink
  before_update :create_permalink
  
  cattr_reader :per_page
  @@per_page = 25
  
  
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/venues/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/venues/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"
  
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  # #########################
  # permalink-related methods
  def to_param
    permalink || super
  end
  
  def find_by_permalink!(permalink, options ={})
    with_scope(:find => { :conditions => ["LOWER(name) = ?", permalink.to_s.downcase]}) do
      first(options) || raise(ActiveRecord::RecordNotFound)
    end
  end
  
  def complete_name
    unless self.city.blank? || self.state.blank? 
      self.name + " " + self.city + ", " + self.state
    else
      self.name 
    end
  end
  
  
  
  def create_permalink
    self.permalink = self.complete_name.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end
  
  
end
