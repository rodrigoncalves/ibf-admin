class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.root?
        can :manage, :all
      elsif user.admin?
        can :manage, :all
        cannot :manage, User, role: :root
      elsif
        can :access, :rails_admin
        can :dashboard
      end
    end
  end
end
