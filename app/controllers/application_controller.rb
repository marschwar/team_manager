class ApplicationController < ActionController::Base
  include CurrentUser
	include CurrentTeam

  before_action :load_teams
  before_action :set_locale
  before_action :force_https

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def set_locale
    custom_locale = params[:locale] || extract_locale_from_accept_language_header
    I18n.locale = custom_locale || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    lang_header = request.env['HTTP_ACCEPT_LANGUAGE']
    lang_header.scan(/^[a-z]{2}/).first if lang_header
  end

  def force_https
    force_ssl_redirect if Rails.env.production?
  end
  
  def load_teams
  	@all_teams = all_teams
  end

  def all_teams
    @all_teams ||= Team.all
  end
end
