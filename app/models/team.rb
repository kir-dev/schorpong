class Team < ApplicationRecord
  include ImageHelper
  has_many :memberships

  has_one_attached :image
  validates :image, dimension: {
                      width: { min: 500 },
                      height: { min: 500 },
                      message: "A képnek legalább 500x500-as méretűnek kell lennie.",
                    }, if: :image?

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

  def delete_memberships!
    memberships.each do |membership|
      membership.decline!
    end
  end
end
