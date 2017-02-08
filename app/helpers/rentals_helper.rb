module RentalsHelper
  def equipment_detail(equipment)
    return unless equipment

    data = [equipment.brand]
    data << "(#{equipment.size})" if equipment.size.present?
    content = data.join(' ')

    dates = [format_date(equipment.rental_date)]
    dates << format_date(equipment.return_date) if equipment.return_date.present?

    content_tag :span do
      if equipment.return_date.present?
        concat content_tag(:s, content)
      else
        concat content
      end
      concat tag(:br)
      concat content_tag(:small, dates.join(' - '), class: 'text-muted')
    end
  end
end
