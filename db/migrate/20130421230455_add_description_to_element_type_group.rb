class AddDescriptionToElementTypeGroup < ActiveRecord::Migration
  def change
    add_column :element_type_groups, :description, :string
  end
end
