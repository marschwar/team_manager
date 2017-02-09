class RentalEquipmentsController < ApplicationController
  load_and_authorize_resource

  def index
    if can? :create, RentalEquipment
      @pad = RentalEquipment.new(inventory_number: 'P')
      @helmet = RentalEquipment.new(inventory_number: 'H')
    end
    @helmets = RentalEquipment.helmets.ordered
    @pads = RentalEquipment.pads.ordered
    respond_to do |format|
      format.html {}
      format.csv {
        filename = 'rental_equipment'
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end

  end

  def create
    rental = RentalEquipment.new rental_equipment_params
    if rental.valid?
      rental.save
    else
      flash[:error] = rental.errors.full_messages.first
    end
    redirect_to rental_equipments_path
  end

  private

  def rental_equipment_params
    params.require(:rental_equipment).permit(:inventory_number, :size, :brand, :serial_number)
  end
end
