class AddListAddBooleanToGrocery < ActiveRecord::Migration[7.0]
  def change
    add_column :groceries, :list_add, :boolean, null: false, default: true
  end
end
