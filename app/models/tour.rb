class Tour < ActiveRecord::Base
  versioned
  
  require 'paperclip'
  belongs_to :band
  has_many :performances
  
  before_create :create_permalink 
  before_update :create_permalink  
  
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/tours/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/tours/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"
  
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  
  def full_name
    self.band.name + " - " + self.name
  end
  
  def full_name_no_spaces
    self.band.name + "-" + self.name
  end
  
  
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
  
  # replace name with whatever the field is to be used for the permalink  
  def create_permalink
    self.permalink = self.full_name_no_spaces.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end  
  
  
  
  # methods for connecting tours and bands
  def headlined_by?(band)
    self.bands.include?(band)
  end
  
  def no_headliner
    Band.find(:all) - self.bands
  end
end
