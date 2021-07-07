class Article < ApplicationRecord
  include ImageHelper

  has_one_attached :image
end
