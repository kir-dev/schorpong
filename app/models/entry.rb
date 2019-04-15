class Entry < ApplicationRecord
  belongs_to :team
  belongs_to :event

  def toggle_showed_up!
    self.showed_up = !self.showed_up
    self.save
  end

  def revocable_by?(current_user)
    team.memberships.any? { |m| m.user == current_user }
  end
end
