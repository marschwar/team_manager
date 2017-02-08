class RentalsController < ApplicationController
  load_and_authorize_resource

  before_action :set_player, except: [:index]

  def index
    if params[:id]
      @team = Team.find params[:id]
      data = Rental.of_team(@team).active.group_by(&:player)
    else
      data = Rental.joins(:player).active.group_by(&:player)
    end

    @equipment = data.map do |player, equipments|
      {
        player: player,
        helmet: equipments.find { |e| e.type == 'Helmet' },
        pad: equipments.find { |e| e.type == 'Pad' }
      }
    end

    @equipment.sort_by! {|e| e[:player].last_name}
  end

  def new
    @rental = Rental.new(player: @player, rental_date: Date.today, type: Rental::TYPES.first)
  end

  def create
    @rental = Rental.new rental_params
    @rental.player = @player
    respond_to do |format|
      if @rental.save
        format.html { redirect_to @player }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    @rental.update rental_params
    @rental.player = @player
    respond_to do |format|
      if @rental.save
        format.html { redirect_to @player }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @rental.destroy
    redirect_to @player
  end

private
  def set_player
    raise unless params[:player_id]
    @player = Player.find params[:player_id]
  end

  def rental_params
    safe_params params[:type].downcase
  end

  def safe_params(type)
    params.require(type).permit(:type, :brand, :size, :rental_date, :return_date)
  end

end
