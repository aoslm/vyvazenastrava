class CreateRecipes < ActiveRecord::Migration
  def up
    #drop_table :recipes
    create_table :recipes do |t|
      t.string :name
      t.float :price
      t.integer :rank
      t.time :time
      t.text :manual
      t.references :food
      t.references :user

      t.timestamps
    end
    add_index :recipes, :food_id
    add_index :recipes, :user_id
  end
end
