class AdddefaultRankToRecipes < ActiveRecord::Migration
  def up
    change_column :recipes, :rank, :integer, :default => 1
    change_column :recipes, :price, :integer, :default => 0
    change_column :recipes, :people, :integer, :default => 1

  end

  def down
  end
end
