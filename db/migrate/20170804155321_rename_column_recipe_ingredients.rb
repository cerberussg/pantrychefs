class RenameColumnRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipe_ingredients, :ingredient_id, :fixing_id
  end
end
