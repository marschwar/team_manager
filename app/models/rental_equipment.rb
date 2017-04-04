class RentalEquipment < ActiveRecord::Base
	FORMAT = /\A[HP]\d{4}\z/
	TYPES = %w(PAD HELMET)

	before_validation :prepare_number

	validates :inventory_number, format: { with: RentalEquipment::FORMAT, message: "muss das Format [HP]1234 haben" }
  validates_uniqueness_of :inventory_number

	scope :with_number, -> (inventory_number) { where(inventory_number: inventory_number).limit(1)}
	scope :helmets, -> { where("inventory_number like 'H%'")}
	scope :pads, -> { where("inventory_number like 'P%'")}
	scope :ordered, -> { order(:inventory_number)}

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

	def rented_out?
		player.present?
	end

	def player
		@_player ||= Rental.with_number(inventory_number).try(:player)
	end

private

	def prepare_number
		number = number.strip.upcase unless number.blank?
	end
end
