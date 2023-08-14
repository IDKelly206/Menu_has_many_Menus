class RemoveRecipeIdFromCourse < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :recipe_id, :string
  end
end
