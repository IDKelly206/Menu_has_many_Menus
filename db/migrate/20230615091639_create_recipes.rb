class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :label
      t.string :source
      t.integer :yield

      t.timestamps
    end
  end
end
