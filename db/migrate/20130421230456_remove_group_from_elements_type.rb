class RemoveGroupFromElementsType < ActiveRecord::Migration
  def up
    remove_column :elements_types, :group
  end

  def down
    add_column :elements_types, :group, :string
  end
end
