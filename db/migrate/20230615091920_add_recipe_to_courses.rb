class AddRecipeToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :recipe, null: false, foreign_key: true
  end
end
