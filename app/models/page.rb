class Page < ActiveRecord::Base
  versioned
  
  before_create :create_permalink
  before_update :create_permalink
  
  def create_permalink
    self.permalink = self.name.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end
end
