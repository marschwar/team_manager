class RentalEquipmentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_player

  def new
    @rental_equipment = RentalEquipment.new(player: @player, rental_date: Date.today, type: RentalEquipment::TYPES.first)
  end

  def create
    @rental_equipment = RentalEquipment.new rental_equipment_params
    @rental_equipment.player = @player
    respond_to do |format|
      if @rental_equipment.save
        format.html { redirect_to @player }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    @rental_equipment.update rental_equipment_params
    @rental_equipment.player = @player
    respond_to do |format|
      if @rental_equipment.save
        format.html { redirect_to @player }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @rental_equipment.destroy
    redirect_to @player
  end
private
  def set_player
    raise unless params[:player_id]
    @player = Player.find params[:player_id]
  end

  def rental_equipment_params
    safe_params params[:type].downcase
  end

  def safe_params(type)
    params.require(type).permit(:type, :brand, :size, :rental_date, :return_date)
  end

end
