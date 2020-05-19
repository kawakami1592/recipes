class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :ingredient, :quantity, presence: true
end
