class RenamegroupIdToelementTypeGroupId < ActiveRecord::Migration
  def up
    rename_column :elements_types, :group_id, :element_type_group_id
  end

  def down
  end
end
