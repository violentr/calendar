class Room < ActiveRecord::Base
  has_many :bookings
end
