module PlayersHelper
  def birthday_of(person)
    I18n.localize person.birthday if person.birthday
  end

  def year_class_element(player)
    return unless player.year_class

    content_tag :span, class: "label label-#{player.year_class.downcase} " do      
      player.year_class
    end
  end
end
