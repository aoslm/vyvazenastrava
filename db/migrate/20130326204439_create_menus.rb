class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :user
      t.references :food
      t.timestamps
    end
    add_index :menus, :user_id
    add_index :menus, :food_id
  end
end
