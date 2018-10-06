class User < ApplicationRecord
  has_many :memberships

  def admin?
    self.admin
  end

  def membership_for(team)
    memberships.find { |m| m.team == team }
  end

  def team_admin?(team)
    memberships.find { |m| m.admin? && m.team == team }
  end

  def admin_of?(team)
    membership = membership_for(team)
    membership&.admin?
  end

  def member_of?(team)
    membership = membership_for(team)
    membership&.active?
  end

  def number_of_memberships
    memberships.size
  end
end
