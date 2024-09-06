class AddColumnsToGroceries < ActiveRecord::Migration[7.0]
  def change
    add_column :groceries, :erecipe_servings, :integer, null: false
    add_column :groceries, :base_vol_qty, :integer
    add_column :groceries, :base_vol_msr, :string
    add_column :groceries, :base_wgt_qty, :integer
    add_column :groceries, :base_wgt_msr, :string
  end
end
