class Maked < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :recipe
  validates :text, presence: true
end
