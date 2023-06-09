class ChangeColumnNameInUser < ActiveRecord::Migration[7.0]
  def change
    rename_column(:meals, :meal_type, :name)
  end
end
