require 'geokit'
require 'vendor/plugins/geokit-rails/init.rb'

class Address < ActiveRecord::Base
  versioned
  acts_as_mappable
  
  has_many :venues
  
  accepts_nested_attributes_for :venues, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => false
  
  before_create :create_permalink
  before_update :create_permalink
  validates_presence_of :lat, :lng
  before_validation_on_create :geocode_address
  before_validation_on_update :geocode_address
  
  cattr_reader :per_page
  @@per_page = 25
  
  def usable
    self.street + " " + self.city + ", " + self.state + " " + self.zip.to_s + " " + self.country
  end
  
  def usable_with_breaks
    self.street + "<br />" + self.city + ", " + self.state + " " + self.zip.to_s + "<br />" + self.country
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
  
  def create_permalink
    self.permalink = self.usable.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end
  
  
  private
  def geocode_address
    geo = GeoKit::Geocoders::MultiGeocoder.geocode(usable)
    errors.add(:usable, "Could not geocode address") unless geo.success
    self.lat, self.lng = geo.lat, geo.lng if geo.success
  end  
end
