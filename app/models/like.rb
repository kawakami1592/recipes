class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :user_id, presence: true
  validates :recipe_id, presence: true
  validates_uniqueness_of :recipe_id, scope: :user_id
end