class AddRecipeIdToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :recipe_id, :string, null: false
  end
end
