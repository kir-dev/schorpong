class Rent < ApplicationRecord
  belongs_to :item
  belongs_to :user
  enum state: [:unprocessed, :approved, :rejected, :taken, :returned], _default: :unprocessed

  validates :begin, presence: true
  validate :begin_cant_be_before_the_present
  validates :end, presence: true , comparison: { greater_than: :begin, message: " később legyen, mint a kezdete." }
  validates :number, presence: true, comparison: { greater_than: 0 }
  validates_with RentNumberValidator


  def begin_cant_be_before_the_present
    if self.begin < Time.now
      errors.add(:begin, "később legyen, mint a mostani időpont.")
    end
  end

  #
  #STATE MACHINE
  def approve!
    raise Exceptions::ForbiddenTransition unless unprocessed?
    approved!
  end

  def reject!
    raise Exceptions::ForbiddenTransition unless unprocessed?
    rejected!
  end

  def take!
    raise Exceptions::ForbiddenTransition unless approved?
    taken!
  end

  def return!
    raise Exceptions::ForbiddenTransition unless taken?
    returned!
  end

  scope :desc, -> { order("rents.id DESC") }

  def self.filter(params)
    states = params.select{ |k,v| v == "1"}.keys
    Rent.where(state: states).desc
  end

  def self.users_filter(params, id)
    states = params.select{ |k,v| v == "1"}.keys
    Rent.where(user_id: id).where(state: states).desc
  end

  def item
    Item.unscoped { super }
  end

  def days
    (self.begin.to_date.. self.end.to_date).to_a
  end
end

