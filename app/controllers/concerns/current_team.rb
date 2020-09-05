module CurrentTeam
  extend ActiveSupport::Concern

  included do
    before_action :check_for_team
  end

  def current_team
    @current_team
  end

  def check_for_team
    team = session_team || cookie_team || first_available
    self.current_team = team
  end

private
  def current_team=(team)
    @current_team = team
    remember_team team 
  end

  def session_team
    load_team session[:current_team_id]
  end

  def first_available
    Team.first
  end

  def cookie_team
    load_team cookies.signed[:current_team_id]
  end

  def remember_team(team)
    self.cookie_team = team
    self.session_team = team
  end

  def cookie_team=(team)
    cookies.signed[:current_team_id] = { value: team.id, expires: 2.months.from_now } if team
  end

  def session_team=(team)
    session[:current_team_id] = team.id if team
  end

  def load_team(id)
    begin
      team = Team.find(id) if id
    rescue
      logger.info "invalid id #{id} in cookie"
    end    
    team
  end
end