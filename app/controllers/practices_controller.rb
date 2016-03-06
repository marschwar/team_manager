class PracticesController < EventsController
  # GET /events
  # GET /events.json
  def index
    @events = Event.eager_load(:participations).practices.for_team(@team).by_date.to_a
    player_ids = @events.map { |e| e.participations.map { |p| p.player_id }}.flatten.uniq
    @players = Player.list(player_ids).sorted
    @participants = @events.map { |e| e.participations.where(participated: true).count }

    @practice_participation = @players.map do |player|
      player_participations = @events.map do |event|
        event.participations.find { |p| p.player == player }
      end
      possible = Participation.where(event: @events, player: player).count
      participated = Participation.where(event: @events, player: player, participated: true).count
      percentage = possible == 0 ? 0 : participated.to_f / possible.to_f * 100.0
      { name: player.full_name, participations: player_participations, percentage: percentage }
    end
    render "index_#{@event_type.downcase}"
  end

private
  def set_event_type
    @event_type = 'Practice'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def practice_params
    params.require(:practice).permit(:type, :name, :event_date, :participation)
  end

  def event_params
    practice_params
  end

end
