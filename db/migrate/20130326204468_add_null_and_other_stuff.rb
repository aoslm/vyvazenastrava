class AddNullAndOtherStuff < ActiveRecord::Migration
  def up
    change_column :categories, :name, :string, :null => false
    change_column :compositions, :food_id, :integer, :null => false
    add_foreign_key :compositions, :foods
    add_foreign_key :compositions, :users
    change_column :elements, :amount, :float, :null => false
    change_column :elements, :elements_type_id, :integer, :null => false
    change_column :elements, :composition_id, :integer, :null => false

    add_foreign_key :elements, :elements_types
    add_foreign_key :elements, :compositions

    change_column :foods, :slovakName, :string, :null => false
    change_column :foods, :user_id, :integer, :null => false
    add_foreign_key :foods, :users
    change_column :foods_types, :food_id, :integer, :null => false
    change_column :foods_types, :type_id, :integer, :null => false
    add_foreign_key :foods_types, :types
    add_foreign_key :foods_types, :foods

    change_column :menus_foods, :menu_id, :integer, :null => false
    change_column :menus_foods, :food_id, :integer, :null => false
    add_foreign_key :menus_foods, :menus
    add_foreign_key :menus_foods, :foods

    change_column :recipes, :name, :string, :null => false
    change_column :recipes, :food_id, :integer, :null => false
    add_foreign_key :recipes, :foods

    change_column :types, :name, :string, :null => false
    change_column :elements, :elements_type_id, :integer, :null => false

    change_column :elements_types, :name, :string, :null => false

    change_column :types_categories, :type_id, :integer, :null => false
    change_column :types_categories, :category_id, :integer, :null => false
    add_foreign_key :types_categories, :types
    add_foreign_key :types_categories, :categories

    change_column :users, :username, :string, :null => false

    change_column :users_menus, :user_id, :integer, :null => false
    change_column :users_menus, :menu_id, :integer, :null => false
    add_foreign_key :users_menus, :users
    add_foreign_key :users_menus, :menus

    change_column :users_recipes, :user_id, :integer, :null => false
    change_column :users_recipes, :recipe_id, :integer, :null => false
    add_foreign_key :users_recipes, :users
    add_foreign_key :users_recipes, :recipes
  end

  def down
  end
end
