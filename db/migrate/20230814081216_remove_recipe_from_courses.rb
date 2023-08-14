class RemoveRecipeFromCourses < ActiveRecord::Migration[7.0]
  def change
    remove_reference :courses, :recipe, null: false, foreign_key: true
  end
end
