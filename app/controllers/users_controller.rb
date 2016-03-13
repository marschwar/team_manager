class UsersController < ApplicationController

  load_and_authorize_resource

  def index
    redirect_to guests_users_path
  end

  def guests
    @users = User.with_role('guest')
    render 'index'
  end

  def all
    @users = User.all
    render 'index'
  end

  def managers
    @users = User.with_role('manager')
    render 'index'
  end

  def update
    @user.update user_params
    if @user.save
      flash[:notice] = "#{@user.common_name} aktualisiert"
      redirect_to users_path
    else
      render partial: 'edit'
    end
  end

  def edit
  end

private

  def user_params
    params.require(:user).permit(:role)
  end
end
