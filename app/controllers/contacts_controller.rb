class ContactsController < ApplicationController
  load_and_authorize_resource

  before_action :set_player, only: [:create, :destroy]
  before_action :set_contact, only: [:destroy]

  def create
    @contact = Contact.new contact_params
    @contact.player = @player
    @contact.save
    flash[:error] = 'foo' if @contact.errors

    redirect_to @player
  end

  def destroy
    @contact.destroy
    redirect_to @player    
  end

private
  def set_player
    @player = Player.find params[:player_id]
  end

  def set_contact
    @contact = Contact.find params[:id]
  end

  def contact_params
    params.require(:contact).permit(:email, :description)
  end

end
