class Recipe < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category, optional: true
  has_many :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :makeds
  accepts_nested_attributes_for :makeds, allow_destroy: true
end
