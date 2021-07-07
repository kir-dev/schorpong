class User < ApplicationRecord
  include ImageHelper

  has_many :memberships
  has_one_attached :image
  validates :image, dimension: {
                      width: { min: 300 },
                      height: { min: 500 },
                      message: "A képnek legalább 300x500-as méretűnek kell lennie.",
                    }, if: :image?

  def admin?
    self.admin
  end

  def membership_for(team)
    memberships.find { |m| m.team == team }
  end

  def team_admin?
    memberships.find { |m| m.admin? }
  end

  def admin_of?(team)
    membership = membership_for(team)
    membership&.admin?
  end

  def member_of?(team)
    membership = membership_for(team)
    membership&.active?
  end

  def can_create_team?
    self.number_of_memberships == 0
  end

  def number_of_memberships
    memberships.size
  end
end
