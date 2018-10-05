class Team < ApplicationRecord
  has_many :memberships

  MAXIMUM_MEMBERSHIPS_COUNT = 2

  def member?(user)
    user.membership_for(self)
  end

  def user_can_join?(current_user)
    !member?(current_user) &&
        !current_user.team_admin? &&
        current_user.number_of_memberships < MAXIMUM_MEMBERSHIPS_COUNT
  end

  def join!(current_user)
    Membership.create(team: self, user: current_user, active: false, owner: false)
  end
end
