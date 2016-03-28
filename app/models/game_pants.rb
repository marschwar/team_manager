class GamePants < TeamEquipment
  
  validates_presence_of :size
  validates_presence_of :count
  validates :count, numericality: { only_integer: true, greater_than_or_equal_to: 0, lesa_than_or_equal_to: 99 }
  validates_uniqueness_of :size, scope: :team_id

  def <=>(other)
    my_idx = SIZES.index(self.size)
    other_idx = SIZES.index(other.size) if other

    if my_idx && other_idx
      my_idx <=> other_idx
    else
      super
    end 
  end
end
