class SessionsController < ApplicationController

  skip_before_action :redirect_to_startpage
  
  def create
    user = auth_service.handle_auth_success auth_hash
    self.session_user_id = user.id
    self.remember_me = user.id
    redirect_to root_path
  end

  def clear
    session.clear
    self.remember_me = nil
    redirect_to '/'
  end

private

  def auth_service
    @auth_service ||= AuthService.new
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
