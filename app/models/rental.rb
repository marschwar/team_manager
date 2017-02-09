class Rental < ActiveRecord::Base
  TYPES = ['Helmet', 'Pad']

  belongs_to :player

  validates_presence_of :type, :rental_date
  validate :rental_equipment_must_exist, :rental_equipment_may_not_be_taken

  scope :active, -> {where(return_date: nil)}
  scope :of_team, -> (team) { joins(:player).where('players.team_id = ? or (players.birthday >= ? and players.birthday <= ?)', team, team.first_day, team.last_day) }

  def self.any_with_number(no)
    Rental.where(inventory_number: no).active
  end

  def self.with_number(no)
    Rental.where(inventory_number: no).active.first
  end

  def equipment
    @_equipment ||= load_equipment
  end

  def brand
    equipment.try(:brand) || super
  end

  def size
    equipment.try(:size) || super
  end

private

  def rental_equipment_must_exist
    if inventory_number.present? && RentalEquipment.with_number(inventory_number).blank?
      errors.add(:inventory_number, "existiert nicht")
    end
  end

  def rental_equipment_may_not_be_taken
    if inventory_number.present?
      rented_to = Rental.any_with_number(inventory_number).where('player_id <> ?', player_id)
      if rented_to.present?
        errors.add(:inventory_number, "ist bereits an #{rented_to.player.full_name} verliehen")
      end
    end
  end

  def load_equipment
    RentalEquipment.with_number(inventory_number).first if inventory_number.present?
  end
end
