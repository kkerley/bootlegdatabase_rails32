class User < ActiveRecord::Base
  require 'paperclip'
  acts_as_authentic
  
  has_many :bootlegs
  has_many :posts
  has_many :recordings, :through => :bootlegs
  has_many :attendances
  has_many :performances, :through => :attendances
  
  has_attached_file :photo, :styles => { :mini => "32x32>", :avatar => "64x64>", :medium => "128x128>", :large => "256x256>" },
                    :url => "/assets/users/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension",
                    :default_url => "/images/missing.png"
  
  
  validates_attachment_size :photo, :less_than => 2.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  before_create :create_permalink
  
  
  def to_xml(options = {})
    default_only =[:id, :username, :given_name, :location, :occupation, :interests, :website, :photo ]
    options[:only] = (options[:only] || []) + default_only
    super(options)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def was_in_attendance?(performance)
    self.performances.include?(performance)
  end
  
  def was_not_in_attedednance
    Performance.find(:all) - self.performances
  end
  
  
  def has_already_collected?(recording)
    self.recordings.include?(recording)
  end
  
  def has_not_yet_been_collected
    Recording.find(:all) - self.recordings
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
    self.permalink = self.login.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end


end
