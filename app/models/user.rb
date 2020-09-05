class User < ApplicationRecord
  scope :with_role, -> (role) { where('role = ?', role) }
end
