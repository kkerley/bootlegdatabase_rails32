class Song < ActiveRecord::Base
  versioned
  
  belongs_to :band
  has_many :played_songs
  has_many :performances, :through => :played_songs
   
  before_create :create_permalink
  before_update :create_permalink
  
  cattr_reader :per_page
  @@per_page = 25
  
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
end
