class AddPeopleToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :people, :integer
  end
end
