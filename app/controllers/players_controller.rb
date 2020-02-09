class PlayersController < ApplicationController
  include UploadSupport

  UPLOAD_ATTRIBUTES = %w(number last_name first_name position birthday licence)

  load_and_authorize_resource

  # GET /players
  # GET /players.json
  def index
    @team = Team.find params[:team_id] if params[:team_id]
    all = @team ? Player.of_team(@team).sorted : Player.all.sorted
    @players = all.select { |p| p.active  }
    @inactive_players = all.select { |p| !p.active  }
    respond_to do |format|
      format.html {}
      format.csv {
        filename = @team ? @team.name.gsub(/\s+/, '_').downcase : 'players'
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    team = @player.actual_team
    if team
      team_players = Player.of_team(team).active.sorted.to_a
      idx = team_players.find_index { |a_player| a_player.id == @player.id}
      if idx
        @previous = team_players[idx - 1] if idx > 0
        @next = team_players[idx + 1] if idx < team_players.count - 1
      end
    end
    @contact = Contact.new
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to team_players_url(current_team), notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    team = upload_team
    flash[:error] = I18n.translate('players.index.upload.errors.team_missing') unless team
    redirect_to players_path and return if flash[:error]

    file = upload_file
    flash[:error] = I18n.translate('players.index.upload.errors.file_missing') unless file
    redirect_to team_players_path(team) and return if flash[:error]

    case file.content_type
    when 'text/csv'
      count = import_file(file) do |data, raw|
        import_player team, data, raw
      end
      flash[:info] = "#{count} Spieler importiert"
    else
      flash[:error] = "unknown content type #{file.content_type}"
    end
    redirect_to team_players_path(team)
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      my_params = params.require(:player).permit(:active, :first_name, :last_name, :birthday, :place_of_birth, :position, :number, :team_id, :team_overwritten, :pants_size, :licence, :note)
      my_params[:team_id] = nil if my_params[:team_overwritten] == '0'
      my_params.delete :team_overwritten
      my_params
    end

    def upload_team
      if params[:upload][:team_id].present?
        Team.find params[:upload][:team_id].to_i
      end
    end

    def upload_file
      params[:upload][:file] if params[:upload][:file].present?
    end

    def upload_attributes
      UPLOAD_ATTRIBUTES
    end

    def import_player(team, player_attributes, player_data)
      player = Player.find_or_create_by(first_name: player_attributes[:first_name], last_name: player_attributes[:last_name])
      player.update_attributes player_attributes
      player.team_id = player.birthday && player.actual_team == team ? nil : team.id
      player.save

      Contact.where(player: player).destroy_all
      addresses = player_data.slice(UPLOAD_ATTRIBUTES.count, player_data.count - UPLOAD_ATTRIBUTES.count) || []
      addresses.each do |email|
        Contact.new(player: player, email: email).save
      end
    end
end
