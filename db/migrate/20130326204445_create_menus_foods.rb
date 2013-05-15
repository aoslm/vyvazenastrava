class CreateMenusFoods < ActiveRecord::Migration
  def change
    create_table :menus_foods do |t|
      t.references :menus
      t.references :food

      t.timestamps
    end
    add_index :menus_foods, :food_id
    add_index :menus_foods, :menu_id
  end
end
