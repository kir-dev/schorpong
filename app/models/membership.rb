class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  def admin?
    self.admin
  end

  def active?
    self.active
  end

  def accept!
    self.active = true
    save
  end
end
