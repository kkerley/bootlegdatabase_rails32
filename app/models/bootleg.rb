class Bootleg < ActiveRecord::Base
  versioned
  
  belongs_to :recording
  belongs_to :user
end
