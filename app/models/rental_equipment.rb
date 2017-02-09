class RentalEquipment < ActiveRecord::Base
	FORMAT = /\A[HP]\d{4}\z/
	TYPES = %w(PAD HELMET)

	validates :inventory_number, format: { with: RentalEquipment::FORMAT, message: "muss das Format [HP]1234 haben" }
  validates_uniqueness_of :inventory_number

	scope :with_number, -> (inventory_number) { where(inventory_number: inventory_number).limit(1)}
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
