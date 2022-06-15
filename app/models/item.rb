class Item < ApplicationRecord
    acts_as_paranoid

    validates :name, presence: true
    validates :number, presence: true, comparison: { greater_than: 0 }

    has_many :rents
end
