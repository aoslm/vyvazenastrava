class CreateFoodsRecipes < ActiveRecord::Migration
  def change
    create_table :foods_recipes do |t|
      t.references :food
      t.references :recipe
      t.timestamps
    end
    add_index :foods_recipes, :food_id
    add_index :foods_recipes, :recipe_id
  end
end
