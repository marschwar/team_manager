class Rental < ActiveRecord::Base
  TYPES = ['Helmet', 'Pad']

  belongs_to :player

  validates_presence_of :type, :rental_date
  validate :rental_equipment_must_exist, :rental_equipment_may_not_be_taken

  scope :active, -> {where(return_date: nil)}
  scope :with_number, -> (inventory_number) {where(inventory_number: inventory_number)}
  scope :of_team, -> (team) { joins(:player).where('players.team_id = ? or (players.birthday >= ? and players.birthday <= ?)', team, team.first_day, team.last_day) }

  def equipment
    @_equipment || load_equipment
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
      errors.add(:inventory_number, "Inventarnummer existiert nicht")
    end
  end

  def rental_equipment_may_not_be_taken
    if inventory_number.present?
      rented_to = Rental.with_number(inventory_number).active.where('player_id <> ?', player_id).first
      if rented_to.present?
        errors.add(:inventory_number, "Equipment ist bereits an #{rented_to.player.full_name} verliehen")
      end
    end
  end

  def load_equipment
    RentalEquipment.with_number(inventory_number).first if inventory_number.present?
  end
end
