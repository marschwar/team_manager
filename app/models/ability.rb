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

    def player
      guest
    end

    def manager
      player

      can [:read, :create, :edit, :update], Player
      can [:change, :depth_chart], Team
      can :manage, Event
      can :manage, Contact
      can :manage, TeamEquipment
      can [:read, :create, :edit, :update], RentalEquipment
    end

    def headcoach
      manager

      can [:destroy, :read_note], Player
    end

    def admin
      headcoach
      can :manage, Team
      can :manage, User
      can :manage, RentalEquipment
    end
end
