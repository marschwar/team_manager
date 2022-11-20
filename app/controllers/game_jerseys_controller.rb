class GameJerseysController < ApplicationController
  include TeamScoped
  include UploadSupport

  UPLOAD_ATTRIBUTES = %w(number size)

  load_and_authorize_resource

  def index
    @jersey = GameJersey.new team_id: @team
    @jerseys = GameJersey.of_team(@team).sorted
  end

  def create
    @jersey = GameJersey.new game_jersey_params
    @jersey.team = @team
    if @jersey.save
      redirect_to team_game_jerseys_path(@team)
    else
      flash[:error] = @jersey.errors.full_messages.first
      @jerseys = []
      render :index
    end
  end

  def upload
    file = upload_file
    flash[:error] = I18n.translate('game_jerseys.index.upload.errors.file_missing') unless file
    redirect_to team_game_jerseys_path(@team) and return if flash[:error]

    case file.content_type
    when 'text/csv'
      count = import_jerseys file
      if count
        flash[:info] = "#{count} Jerseys importiert"
      else
        flash[:error] = "error importing jerseys"
      end
    else
      flash[:error] = "unknown content type #{file.content_type}"
    end
    redirect_to team_game_jerseys_path(@team)
  end

  def destroy
    @game_jersey.destroy
    redirect_to team_game_jerseys_path @team
  end

private

  def game_jersey_params
    params.require(:game_jersey).permit(:size, :number)
  end

  def upload_file
    params[:upload][:file] if params[:upload] && params[:upload][:file].present?
  end

  def import_jerseys(file)
    import_file(file) do |jersey_attributes|
      jersey = GameJersey.find_or_create_by(number: jersey_attributes[:number], team_id: @team)
      jersey.update jersey_attributes
      jersey.team = @team
      jersey.save
    end
  end

  def upload_attributes
    UPLOAD_ATTRIBUTES
  end

end
