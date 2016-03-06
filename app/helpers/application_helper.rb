module ApplicationHelper

  def format_date(date)
    I18n.localize date if date
  end
end
