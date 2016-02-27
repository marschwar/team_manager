class User < ActiveRecord::Base
  scope :with_role, -> (role) { where('role = ?', role) }
end
