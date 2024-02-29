class CreateDietaryRestrictions < ActiveRecord::Migration[7.0]
  def change
    create_table :dietary_restrictions do |t|
      t.references :user, foreign_key: true
      t.references :health, foreign_key: true
      t.timestamps
    end
  end
end
