class PracticesController < EventsController
  FILTER = %w(4 8 12 24)

  # GET /events
  # GET /events.json
  def index
    @filter = FILTER
    @since = since
    @events = Practice.eager_load(:participations).after(events_since_date).for_team(@team).by_date.to_a
    player_ids = @events.map { |e| e.participations.map { |p| p.player_id }}.flatten.uniq
    @players = Player.list(player_ids).sorted
    @participants = @events.map { |e| e.participations.where(participated: true).count }

    all_participations = Participation.where(event: @events).to_a.group_by(&:player_id)

    @practice_participation = @players.map do |player|
      player_participations = @events.map do |event|
        all_participations[player.id].find {|p| p.event_id == event.id}
      end
      possible = player_participations.count {|p| p.present?}
      participated = player_participations.count {|p| p.present? && p.participated}
      percentage = possible == 0 ? 0 : participated.to_f / possible.to_f * 100.0
      { name: player.full_name, participations: player_participations, percentage: percentage, active: player.active }
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

  def since
    params[:since] || FILTER[0]
  end

  def events_since_date
    since.to_i.weeks.ago.to_date
  end

end
