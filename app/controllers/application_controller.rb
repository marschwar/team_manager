class ApplicationController < ActionController::Base
  include CurrentUser
	include CurrentTeam

  before_action :redirect_to_startpage
  before_action :load_teams
  before_action :set_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def set_locale
    I18n.locale = custom_locale || I18n.default_locale
  end

  def custom_locale
    # disabled for now
    # params[:locale] || extract_locale_from_accept_language_header    
  end

  def extract_locale_from_accept_language_header
    lang_header = request.env['HTTP_ACCEPT_LANGUAGE']
    lang_header.scan(/^[a-z]{2}/).first if lang_header
  end

  def redirect_to_startpage
    redirect_to root_path unless @current_user.present?
  end

  def load_teams
  	@all_teams = all_teams
  end

  def all_teams
    @all_teams ||= Team.all
  end
end
