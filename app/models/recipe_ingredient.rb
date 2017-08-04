class RecipeIngredient < ApplicationRecord
  belongs_to :fixing
  belongs_to :recipe
end