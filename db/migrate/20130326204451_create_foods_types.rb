class CreateFoodsTypes < ActiveRecord::Migration
  def change
    create_table :foods_types do |t|
      t.references :food
      t.references :type

      t.timestamps
    end
    add_index :foods_types, :food_id
    add_index :foods_types, :type_id
  end
end
