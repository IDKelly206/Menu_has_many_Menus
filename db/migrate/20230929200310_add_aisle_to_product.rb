class AddAisleToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :aisle, :string, array: true, default: []
  end
end
