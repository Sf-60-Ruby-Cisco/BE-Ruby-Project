# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :manage, Car, user_id: user.id
      can :manage, Repair
      can :manage, Tax
      can :manage, Charging
    end
  end
end

