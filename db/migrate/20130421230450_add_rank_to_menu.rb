class AddRankToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :rank, :integer
    change_column :menus, :user_id, :integer, :null =>false
  end
end
