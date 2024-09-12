class AddMenuToGroceries < ActiveRecord::Migration[7.0]
  def change
    add_reference :groceries, :menu, null: false, foreign_key: true
  end
end
