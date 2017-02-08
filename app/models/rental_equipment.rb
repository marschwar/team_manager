class RentalEquipment < ActiveRecord::Base
	TYPES = %w(PAD HELMET)

	validates :inventory_number, format: { with: /\A[HP]\d{4}\z/, message: "muss das Format [HP]1234 haben" }
  validates_uniqueness_of :inventory_number

	scope :helmets, -> { where("inventory_number like 'H%'")}
	scope :pads, -> { where("inventory_number like 'P%'")}

	def type
		case inventory_number
		when /\AH.*/
			:HELMET
		when /\AP.*/
			:PAD
		else
			:unknown
		end
	end

end
