class CreateTypesCategories < ActiveRecord::Migration
  def change
    create_table :types_categories do |t|
      t.references :type
      t.references :category

      t.timestamps
    end
    add_index :types_categories, :type_id
    add_index :types_categories, :category_id
  end
end
