class Performance < ActiveRecord::Base
  versioned
  
  require 'paperclip'
  
  belongs_to :tour
  belongs_to :venue
  has_and_belongs_to_many :performers
  has_many :played_songs
  has_many :songs, :through => :played_songs
  has_one :address, :through => :venue
  has_one :band, :through => :tour
  has_many :recordings
  has_many :attendances
  has_many :users, :through => :attendances

  accepts_nested_attributes_for :played_songs, :reject_if => lambda { |a| a[:song_name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :recordings, :reject_if => lambda { |a| a[:taper_name].blank? }, :allow_destroy => false

  before_create :create_permalink
  before_update :create_permalink  
  validates_uniqueness_of :permalink
 
  #cattr_reader :per_page
  #@@per_page = 25
 
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/performances/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/performances/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"
  
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  #Sphinx-related indexing
  define_index do
    indexes date, :sortable => :true
    indexes description
    indexes tour.name, :as => :tour_name
    indexes songs.name, :as => :song_name
    indexes tour.band.name, :as => :band_name
    indexes recordings.taper.name, :as => :recording_taper_name
    indexes venue.name, :as => :venue_name
    indexes venue.city, :as => :venue_city
    indexes venue.state, :as => :venue_state
  end
  
  
 
  def compact
    unless self.venue.city.blank? || self.venue.state.blank?
      self.date.to_s + " - " + self.venue.name + ": " + self.venue.city + ", " + self.venue.state
    else
      self.date.to_s + " - " + self.venue.name
    end
  end
  
  def compact_with_band
    unless self.venue.city.blank? || self.venue.state.blank?
      self.tour.band.name + ": " + self.date.to_s + " - " + self.venue.name + ": " + self.venue.city + ", " + self.venue.state
    else
      self.tour.band.name + ": " + self.date.to_s + " - " + self.venue.name
    end
  end
  
  # same as compact but removing the additional spaces around the - so the permalink will be pretty
  def name
    unless self.venue.city.blank? || self.venue.state.blank?
      self.tour.band.name + "-" + self.date.to_s + "-" + self.venue.name + ": " + self.venue.city + ", " + self.venue.state
    else
      self.tour.band.name + "-" + self.date.to_s + "-" + self.venue.name
    end
  end
  
  def venue_listing
    unless self.venue.city.blank? || self.venue.state.blank?
      self.tour.band.name + ": " + self.date.to_s + " - " + self.venue.name + ": " + self.venue.city + ", " + self.venue.state
    else
      self.date.to_s + "-" + self.venue.name
    end
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
  
  
  # ####################
  # Song-related methods
  def was_played?(song)
    self.songs.include?(song)
  end
   
  def was_not_played
    Song.find(:all) - self.songs
  end
  
  
  # #########################
  # Performer-related methods
  def performed_at?(performer)
    self.performers.include?(performer)
  end
  
  def did_not_perform_at
    Performer.find(:all) - self.performers
  end
  
  # #########################
  # Venue-related methods
  def venue_name
    venue.name if venue unless venue.blank?
  end
  
  def venue_name=(name)
    self.venue = Venue.find_or_create_by_name(name) unless name.blank?
  end
  
  
  # #########################
  # Tour-related methods
  def tour_name
    tour.name if tour unless tour.blank?
  end
  
  def tour_name=(name)
    self.tour = Tour.find_or_create_by_name(name){|t| t.band_id = 2 } unless name.blank?
  end
  
  # #########################
  # Taper-related methods
  
  def taper_name
    taper.name if taper unless taper.blank?
  end
  
  def taper_name=(name)
    self.taper = Taper.find_or_create_by_name(name) unless name.blank?
  end
  
end
