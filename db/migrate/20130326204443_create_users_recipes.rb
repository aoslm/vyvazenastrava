class CreateUsersRecipes < ActiveRecord::Migration
  def change
    create_table :users_recipes do |t|
      t.references :user
      t.references :recipe

      t.timestamps
    end
    add_index :users_recipes, :user_id
    add_index :users_recipes, :recipe_id

  end
end
