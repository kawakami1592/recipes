class Recipe < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category
  has_many :ingredient
  has_many :maked

end
