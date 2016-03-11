class RentalEquipment < ActiveRecord::Base
  TYPES = ['Helmet', 'Pad']

  belongs_to :player

  validates_presence_of :type, :rental_date
end
