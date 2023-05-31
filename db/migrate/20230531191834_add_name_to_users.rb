class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name_first, :string
    add_column :users, :name_last, :string
  end
end
