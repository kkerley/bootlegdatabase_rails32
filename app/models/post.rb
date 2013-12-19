class Post < ActiveRecord::Base
  versioned
  # acts_as_taggable
  
  belongs_to :user
  
  before_create :create_permalink  
  
  def complete_name
    Date.today.to_s + " " + self.title
  end  
  
  def create_permalink
    self.permalink = self.complete_name.gsub(/\s/, "-").gsub(/_/, '-').gsub(/[^\w-]/, '').downcase
  end

end
