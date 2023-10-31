class AddScaleToQuantityColumnToFloatInGrocery < ActiveRecord::Migration[7.0]
  def change
    change_column :groceries, :quantity, :float, scale: 2
  end
end
