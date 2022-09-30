# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :manage, Car, user_id: user.id
      can :manage, Repair, user_id: user.id
      can :manage, Tax, user_id: user.id
      can :manage, Charging, user_id: user.id
    end
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
