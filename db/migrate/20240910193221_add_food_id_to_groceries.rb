class AddFoodIdToGroceries < ActiveRecord::Migration[7.0]
  def change
    add_column :groceries, :food_id, :string, null: false
  end
end
