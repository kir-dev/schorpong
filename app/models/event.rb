class Event < ApplicationRecord
  has_many :entry
  mount_uploader :image, ImageUploader

  def entered?(team)
    team.enetered_for?(self)
  end

  def users_team_can_entry?(current_user)
     self.users_memberships(current_user)&.any? && self.can_entry?
  end

  def users_memberships(current_user)
    return unless current_user
    current_user&.memberships.select { |m| !entered?(m.team) && m.active? }
  end

  def can_entry?
    Time.now < self.application_deadline
  end
end
