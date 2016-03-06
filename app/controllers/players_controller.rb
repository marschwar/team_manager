class PlayersController < ApplicationController
  UPLOAD_ATTRIBUTES = %w(last_name first_name birthday position)

  load_and_authorize_resource

  # GET /players
  # GET /players.json
  def index
    @team = Team.find params[:team_id] if params[:team_id]
    @players = @team ? Player.of_team(@team).sorted : Player.all.sorted
  end

  # GET /players/1
  # GET /players/1.json
  def show
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
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
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
      count = import_players file, team
      if count
        flash[:info] = "#{count} Spieler importiert"
      else
        flash[:error] = "error importing players"
      end
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
      my_params = params.require(:player).permit(:first_name, :last_name, :birthday, :position, :team_id, :team_overwritten)
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

    def import_players(file, team)
      file.read.gsub( /\r\n/, "\n" ).force_encoding('ISO-8859-1').split("\n").each do |line|
        player_data = line.split(';')
        next unless player_data.count > 1
        player_attributes = {}
        UPLOAD_ATTRIBUTES.each_with_index do |attr, idx|
          player_attributes[attr.to_sym] = player_data[idx].encode('UTF-8')
        end
        player = Player.where(first_name: player_attributes[:first_name], last_name: player_attributes[:last_name]).first || Player.new
        player.update_attributes player_attributes
        player.team_id = player.birthday && player.actual_team == team ? nil : team.id
        player.save

        Contact.where(player: player).destroy_all
        player_data.slice(UPLOAD_ATTRIBUTES.count, player_data.count - UPLOAD_ATTRIBUTES.count).each do |email|
          Contact.new(player: player, email: email).save
        end
      end
    end
end
