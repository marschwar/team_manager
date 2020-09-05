class ContactsController < ApplicationController
  load_and_authorize_resource

  before_action :set_player
  before_action :set_contact, only: [:edit, :destroy]

  def create
    @contact = Contact.new contact_params
    @contact.player = @player
    @contact.save
    flash[:error] = @contact.errors.full_messages.first if @contact.errors.present?

    redirect_to @player
  end

  def destroy
    @contact.destroy
    redirect_to @player    
  end

  def edit    
  end

  def update
    if @contact.update(contact_params)
      redirect_to @player, notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

private
  def set_player
    @player = Player.find params[:player_id]
  end

  def set_contact
    @contact = Contact.find params[:id]
  end

  def contact_params
    params.require(:contact).permit(:description, :email, :phone)
  end

end
