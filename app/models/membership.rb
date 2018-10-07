class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  def admin?
    self.owner
  end

  def active?
    self.active
  end

  def approve!
    self.active = true
    save
  end

  def decline!
    self.destroy
  end

  def can_destroy?(current_user)
    current_user.eql?(self.user) && !self.owner ||
        !current_user&.eql?(self.user) && !current_user&.admin_of?(self.team) ||
        current_user.eql?(self.user) && self.team.number_of_memberships == 1
  end
end
