class UsersController < ApplicationController

  load_and_authorize_resource

  def index
    redirect_to guests_users_path
  end

  def guests
    @users = User.with_role('guest')
    render 'index'
  end

  def players
    @users = User.with_role('player')
    render 'index'
  end

  def managers
    @users = User.with_role('manager')
    render 'index'
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = "#{@user.common_name} aktualisiert"
      redirect_to users_path
    else
      render partial: 'edit'
    end
  end

private

  def user_params
    params.require(:user).permit(:role)
  end
end
