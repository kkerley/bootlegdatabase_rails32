class Recording < ActiveRecord::Base
  versioned
  # acts_as_taggable
  
  belongs_to :performance
  belongs_to :taper
  has_many :bootlegs
  has_many :users, :through => :bootlegs
  
  cattr_reader :per_page
  @@per_page = 25
  
  before_create :create_permalink
  before_update :create_permalink
  
  
  
  def name
    self.performance.name + " (" + self.recording_format + " recorded by " + self.taper.name + ")"
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
  
  
  
  
  def taper_name
    taper.name if taper unless taper.blank?
  end
  
  def taper_name=(name)
    self.taper = Taper.find_or_create_by_name(name) unless name.blank?
  end
  
  
  
end
