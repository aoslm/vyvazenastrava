class AddIndexToFoodsOnSlovakName < ActiveRecord::Migration
  def change
    add_index "foods", ["slovakname"], :name => "index_foods_on_slovakname"
  end
end
