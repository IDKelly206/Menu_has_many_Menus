class AddImagesToRecipes < ActiveRecord::Migration[7.0]
  def change
      add_column :recipes, :images, :jsonb, default: {}
  end
end
