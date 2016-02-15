module CurrentTeam
  extend ActiveSupport::Concern

  included do
    before_filter :check_for_team
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
    Team.find(session[:current_team_id]) if session[:current_team_id]
  end

  def first_available
    team = Team.first
    session_team_id = team.id if team
    team
  end

  def cookie_team
    id = cookies.signed[:current_team_id]
    begin
      team = Team.find(id) if id
    rescue
      logger.info "invalid id #{id} in cookie"
    end
    team
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
end