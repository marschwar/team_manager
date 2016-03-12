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
      can :manage, Contact
      can :manage, TeamEquipment
      can [:read, :create, :edit, :update], RentalEquipment
    end

    def admin
      manager
      can :manage, User
      can :manage, RentalEquipment
    end
end
