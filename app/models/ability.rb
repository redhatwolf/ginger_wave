# To change this template, choose Tools | Templates
# and open the template in the editor.

class Ability
  include CanCan::Ability
  def initialize(user)
    if user.role == 'Admin'
      can :manage,:all
    else
      can :read,:all
    end
  end
end
