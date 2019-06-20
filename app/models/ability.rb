# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user, :roles

  def initialize(user)
    clear_aliased_actions

    @user = user || User.new
    @roles = user.roles.to_a

    # can :manage, :all
  end
end
