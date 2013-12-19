class Attendance < ActiveRecord::Base
  belongs_to :performance
  belongs_to :user
end
