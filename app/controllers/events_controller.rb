class EventsController < ApplicationController
  include TeamScoped

  load_and_authorize_resource

  EVENT_TYPES = %w(Practice)

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_event_type

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    render "index_#{@event_type.downcase}"
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @participations = @event.participations.sort { |one, other| one.player.full_name <=> other.player.full_name }
  end

  # GET /events/new
  def new
    @event = Event.new(event_date: Time.now, type: @event_type)
    @participations = @team.players.map { |p| Participation.new(player: p, event: @event) }
  end

  # GET /events/1/edit
  def edit
    @participations = @event.participations
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.team = @team
    @event.type = @event_type

    respond_to do |format|
      success = @event.save
      save_participations_for @event if success
      if success
        format.html { redirect_to team_event_path(@team, @event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      success = @event.update(event_params)
      save_participations_for @event if success
      if success
        format.html { redirect_to [@team, @event], notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to team_events_url(@team), notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_event_type
      @event_type = @event.try(:type) || EVENT_TYPES.include?(params[:type]) ? params.delete(:type) : 'Event'
    end

    def save_participations_for(event)
      p participation_params
      participation_params.each_pair do |id, participation|
        player = Player.find id
        participated = participation[:participated] == '1'
        participation = Participation.where(event: event, player: player).first || Participation.new
        participation.update_attributes(event: event, player: player, participated: participated)
        participation.save
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:type, :name, :event_date, :participation)
    end

    def participation_params
      params.require(:participation)
    end
end
