class RemoveUserIdFromMenu < ActiveRecord::Migration
  def up
    remove_column :menus, :user_id
  end

  def down
    add_column :menus, :user_id, :integer
  end
end
