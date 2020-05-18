class Recipe < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :difficulty
  belongs_to_active_hash :sex
  belongs_to :user
  belongs_to :category, optional: true
  has_many :ingredients, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_many :makeds
  accepts_nested_attributes_for :makeds, allow_destroy: true
  mount_uploader :image, ImageUploader
end
