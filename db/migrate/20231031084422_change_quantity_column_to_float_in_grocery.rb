class ChangeQuantityColumnToFloatInGrocery < ActiveRecord::Migration[7.0]
  def change
    change_column :groceries, :quantity, :float
  end
end
