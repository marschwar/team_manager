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

    def staff
      player

      can :read, Player
      can :select, Team
      can :read, TeamEquipment
    end

    def manager
      staff

      can [:read, :create, :edit, :update], Player
      can [:select, :depth_chart, :contacts, :by_year], Team
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
