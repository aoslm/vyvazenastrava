class AddElementTypeGroup < ActiveRecord::Migration
  def up
    create_table :element_type_groups do |t|
      t.string :name
      t.timestamps
    end


    add_column :elements_types, :group_id, :integer
    add_index :elements_types, :group_id

  end

  def down
  end
end
