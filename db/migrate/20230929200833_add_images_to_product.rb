class AddImagesToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :images, :jsonb, default: {}
  end
end
