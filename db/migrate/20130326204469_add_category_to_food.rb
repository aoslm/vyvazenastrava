class AddCategoryToFood < ActiveRecord::Migration
  def change
    add_column :foods, :category_id, :integer, :null => false
    add_foreign_key :foods, :categories
  end
end
