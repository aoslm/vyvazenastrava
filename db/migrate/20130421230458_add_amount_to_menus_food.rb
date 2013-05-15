class AddAmountToMenusFood < ActiveRecord::Migration
  def change
    add_column :menus_foods, :amount, :integer, :default => 100
  end
end
