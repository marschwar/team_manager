class Contact < ActiveRecord::Base

  belongs_to :player

  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s.])+[^@\s]+\z/
end
