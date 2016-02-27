class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if user.try(:role)
      send(user.role)
    else
      guest
    end
  end

private
    def guest
    end

    def user
      guest
    end

    def player
      guest
    end

    def manager
      user
      can :manage, Team
      can :manage, Player
      can :manage, Event
    end

    def admin
      manager
      can :manage, User
    end
end
