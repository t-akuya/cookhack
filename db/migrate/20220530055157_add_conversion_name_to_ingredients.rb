class AddConversionNameToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :conversion_name, :string
  end
end
