class CreateGroceries < ActiveRecord::Migration[7.0]
  def change
    create_table :groceries do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.string :measurement, null: false
      t.string :category
      t.string :erecipe_id, null: false
      t.references :household, null: false, foreign_key: true

      t.timestamps
    end
  end
end
