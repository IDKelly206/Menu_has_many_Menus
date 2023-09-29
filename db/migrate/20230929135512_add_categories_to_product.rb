class AddCategoriesToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :kproduct_id, :string, null: false
    add_column :products, :upc, :string
  end
end
