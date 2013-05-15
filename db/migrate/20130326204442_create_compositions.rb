class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.integer :rank
      t.references :user
      t.references :food

      t.timestamps
    end
    add_index :compositions, :user_id
    add_index :compositions, :food_id

  end
end
