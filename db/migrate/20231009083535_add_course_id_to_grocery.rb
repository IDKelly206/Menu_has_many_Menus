class AddCourseIdToGrocery < ActiveRecord::Migration[7.0]
  def change
    add_reference :groceries, :course, null: false, foreign_key: true
  end
end
