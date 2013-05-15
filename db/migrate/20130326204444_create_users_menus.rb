class CreateUsersMenus < ActiveRecord::Migration
  def change
    create_table :users_menus do |t|
      t.references :user
      t.references :menus

      t.timestamps
    end
    add_index :users_menus, :user_id
    add_index :users_menus, :menu_id

  end
end
