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

    def manager
      user
      can :manage, Team
    end

    def admin
      manager
      can :manage, User
    end
end
