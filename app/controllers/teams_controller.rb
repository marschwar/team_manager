class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :select]

  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  def select
    session[:current_team_id] = @team.id
    redirect_to team_players_path(@team)
  end

  def depth_chart
    players = Player.of_team(@team).active.sorted

    @by_year = Player::YEAR_CLASSES.map{ |year| {"#{year}": players.select { |p| year == p.year_class }}}
    @offense = Player::OFFENSE_POSITIONS.map{ |pos| {"#{pos}": players.select { |p| pos == p.position }}}
    @defense = Player::DEFENSE_POSITIONS.map{ |pos| {"#{pos}": players.select { |p| pos == p.position }}}
  end

  def contacts
    players = Player.of_team(@team).active.sorted

    @players = players.reject { |p| p.contacts.blank? }
  end

  def by_year
    players = Player.of_team(@team).active.sorted

    @by_year = Player::YEAR_CLASSES.map{ |year| {"#{year}": players.select { |p| year == p.year_class }}}
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :year_from, :year_until)
    end
end
