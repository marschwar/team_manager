module PlayersHelper
  def birthday_of(person)
    format_date person.birthday
  end

  def year_class_element(player)
    return unless player.year_class

    content_tag :span, class: "label label-#{player.year_class.downcase} " do      
      player.year_class
    end
  end
end
