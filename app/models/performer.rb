class Performer < ActiveRecord::Base
  versioned
  
  require 'paperclip'
  has_and_belongs_to_many :bands
  has_and_belongs_to_many :performances
  
  before_update :create_permalink
  
  cattr_reader :per_page
  @@per_page = 25
  
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/performers/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/performers/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"
  
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  
  
  def name
    self.first_name + " " + self.last_name
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
    self.permalink = self.name.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end
  
  def member_of?(band)
    self.bands.include?(band)
  end
  
  def does_not_perform_with
    Band.find(:all) - self.bands
  end
end
