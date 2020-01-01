class Article < ApplicationRecord
  include ImageHelper
  mount_uploader :image, ImageUploader
  has_one_attached :new_image
end
