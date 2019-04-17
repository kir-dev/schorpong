class Team < ApplicationRecord
  has_many :memberships

  mount_uploader :image, ImageUploader

  validate :check_dimensions
  def check_dimensions
    return unless !image_cache.nil? && (image.width < 500 || image.height < 500)

    errors.add :image, 'A képnek legalább 500x500-as méretűnek kell lennie.'
  end

  MAXIMUM_MEMBERSHIPS_COUNT = 2
  MAXIMUM_MEMBER_COUNT = 3

  def member?(user)
    user.membership_for(self)
  end

  def entered_for?(event)
    event.entry.find { |e| e.team == self }
  end

  def user_can_join?(current_user)
    current_user &&
      number_of_memberships != 0 &&
      !member?(current_user) &&
      !current_user.team_admin? &&
      number_of_memberships < MAXIMUM_MEMBER_COUNT &&
      current_user.number_of_memberships < MAXIMUM_MEMBERSHIPS_COUNT
  end

  def number_of_memberships
    memberships.size
  end

  def join!(current_user)
    Membership.create(team: self, user: current_user, active: false, owner: false)
  end
end
