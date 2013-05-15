class CompletingDatabase < ActiveRecord::Migration
  def up
    #remove_column(:foods, :user_id)
   # remove_column(:menus, :user_id)
   # remove_column(:menus, :food_id)
   # rename_table(:foods_types, :foods_type)


   # drop_table :compositions

   # create_table :compositions do |t|
  #    t.integer :rank
   #   t.references :user
   #   t.references :food
    #end

   # add_index :compositions, :user_id
   # add_index :compositions, :food_id


    create_table(:elements_types) do |t|
      t.string :name
      t.text :description
      t.float :GDA_man
      t.float :GDA_woman
      t.float :GDA_child
      t.string :unit
      t.timestamps
    end

    create_table(:elements) do |t|
      t.float :amount
      t.references :composition
      t.references :elements_type
      t.timestamps
    end
      add_index :elements, :composition_id
      add_index :elements, :elements_type_id

  end
  def down
  end
end
