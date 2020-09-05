module TeamScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_team
  end

  def set_team
    team_id = params.delete :team_id
    raise unless team_id
    
    @team = Team.find team_id
  end
end