class Band < ActiveRecord::Base
  versioned
  
  require 'paperclip'
  has_and_belongs_to_many :performers
  has_many :performances 
  has_many :tours
  has_many :songs
  # has_many :recordings
 
  before_update :create_permalink
 
  accepts_nested_attributes_for :performances
  accepts_nested_attributes_for :songs
 
  
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/bands/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/bands/:id/:style/:basename.:extension",
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
  
  # replace name with whatever the field is to be used for the permalink  
  def create_permalink
    self.permalink = self.name.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end
end
