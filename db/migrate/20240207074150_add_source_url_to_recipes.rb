class AddSourceUrlToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :source_url, :string
  end
end
