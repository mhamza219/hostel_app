class Booking < ApplicationRecord
  
  belongs_to :room
  belongs_to :resident


  enum status: { pending: 0, confirmed: 1, canceled: 2 }

end
