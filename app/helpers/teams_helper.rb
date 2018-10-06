module TeamsHelper
  def active_members(team)
    @active_members = team.memberships.select(&:active?)
  end

  def inactive_members(team)
    @inactive_members = team.memberships.select { |m| !m.active? }
  end
end
