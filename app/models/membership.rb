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
end
