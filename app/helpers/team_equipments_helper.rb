module TeamEquipmentsHelper
  def jersey_players(jersey)
    capture do
      jersey.players.each_with_index do |player, idx|
        concat ', ' if idx > 0
        concat link_to player.full_name, player_path(player) 
      end
    end
  end

  def jersey_positions(jersey)
    jersey.players.first.position if jersey.players.count == 1
  end

  def jersey_pants_size(jersey)
    jersey.players.first.pants_size if jersey.players.count == 1
  end
end
