class Participation < ApplicationRecord
	belongs_to :player
	belongs_to :event
end
