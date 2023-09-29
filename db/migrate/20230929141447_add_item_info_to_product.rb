class AddItemInfoToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :item_info, :jsonb, default: {}
  end
end
