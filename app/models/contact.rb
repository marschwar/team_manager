class Contact < ActiveRecord::Base

  before_validation :strip_email_address

  belongs_to :player

  validate :any_field_must_be_set
  validates_format_of :email, with: /\A[^@\s]+@([^@\s.])+[^@\s]+\z/, unless: Proc.new { |c| c.email.blank? }

private

  def strip_email_address
    email = email.strip unless email.blank?
  end

  def any_field_must_be_set
  	if description.blank? && email.blank? && phone.blank?
  		errors.add :email, 'At least one field must be set'
  	end
  end
end
