class AddIngredientIdToRepertoires < ActiveRecord::Migration[6.0]
  def change
    add_column :repertoires, :ingredient_id, :string
  end
end
