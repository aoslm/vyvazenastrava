class AddgroupToElementsTypes < ActiveRecord::Migration
  def up
    add_column :elements_types, :group, :string
  end

  def down
    remove_column :elements_types, :group
  end
end
