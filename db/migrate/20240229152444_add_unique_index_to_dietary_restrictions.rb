class AddUniqueIndexToDietaryRestrictions < ActiveRecord::Migration[7.0]
  def change
    add_index :dietary_restrictions, [:user_id, :health_id], unique: true
  end
end
