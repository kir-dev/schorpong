class Entry < ApplicationRecord
  belongs_to :team
  belongs_to :event

  def toggle_showed_up!
    self.showed_up = !self.showed_up
    self.save
  end
end
