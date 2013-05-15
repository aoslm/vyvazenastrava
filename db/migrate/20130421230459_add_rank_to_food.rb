class AddRankToFood < ActiveRecord::Migration
  def change
    add_column :foods, :rank, :integer ,default: 1
  end
end
