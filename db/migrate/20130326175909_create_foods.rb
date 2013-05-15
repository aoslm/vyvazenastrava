class CreateFoods < ActiveRecord::Migration
  def change
   # drop_table :foods
    create_table :foods do |t|
      t.string :slovakName
      t.string :englishName
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :foods, :user_id
  end
end
