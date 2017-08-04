class RenameIngredientsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :ingredients, :fixings
  end
end
