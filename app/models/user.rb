class User < ApplicationRecord
  has_many :memberships
  has_secure_password validations: false
  validates :mail,  presence: true, uniqueness: {message: " már foglalt!" }
  validates :password, length: {minimum: 6,message:"túl rövid!"}               
  mount_uploader :image, ImageUploader

  validate :check_dimensions
  def check_dimensions
    return unless !image_cache.nil? && (image.width < 500 || image.height < 500)
    errors.add :image, 'A képnek legalább 300x500-as méretűnek kell lennie.'
  end

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
