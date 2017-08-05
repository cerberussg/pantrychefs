class RenameRecipeIngredientsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :recipe_ingredients, :recipe_fixings
  end
end
