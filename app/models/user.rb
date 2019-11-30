class User < ApplicationRecord
  include BCrypt

  has_many :memberships
  has_secure_password

  mount_uploader :image, ImageUploader

  validate :check_dimensions
  validates :mail,  presence: true, uniqueness: { message: ' már foglalt' }
  validates :password, length: { minimum: 6, message: 'túl rövid' }, on: :create

  def check_dimensions
    return unless !image_cache.nil? && (image.width < 500 || image.height < 500)
    errors.add :image, 'A képnek legalább 300x500-as méretűnek kell lennie.'
  end

  def admin?
    admin
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
    number_of_memberships == 0
  end

  def number_of_memberships
    memberships.size
  end

  def create_random_password
    update(password_digest: Password.create(SecureRandom.hex(30)))
  end
end
