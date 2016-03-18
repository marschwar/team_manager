module PlayersHelper
  def birthday_of(person)
    format_date person.birthday
  end

  def year_class_element(player)
    year_class_element_for_year player.year_class if player.year_class
  end

  def year_class_element_for_year(year)
    return unless year

    content_tag :span, class: "label label-#{year.downcase} " do      
      concat year
    end
  end
end
