class Contact < ActiveRecord::Base

  before_validation :strip_email_address

  belongs_to :player

  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s.])+[^@\s]+\z/

private

  def strip_email_address
    email = email.strip unless email.blank?
  end
end
