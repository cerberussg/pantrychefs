class Fixing < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  has_many :recipe_fixings
  has_many :recipes, through: :recipe_fixings
end