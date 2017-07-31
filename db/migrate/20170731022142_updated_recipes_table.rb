class UpdatedRecipesTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :description
    add_column :recipes, :ingredients, :text
    add_column :recipes, :directions, :text
  end
end
