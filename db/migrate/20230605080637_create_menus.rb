class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.date :date
      t.references :household, null: false, foreign_key: true

      t.timestamps
    end
  end
end
