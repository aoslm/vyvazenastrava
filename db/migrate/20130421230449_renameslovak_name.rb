class RenameslovakName < ActiveRecord::Migration
  def up
    rename_column :foods,:slovakName,:slovakname
  end

  def down
  end
end
