class AddErecipeIdToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :erecipe_id, :string, null: false
  end
end
