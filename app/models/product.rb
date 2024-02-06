class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def product_img(attrs = {})
    per = attrs[:perspective]
    sze = attrs[:size]
    images = self.images.select { |p| p["perspective"] == per }
    images.first["sizes"].select { |s| s["size"] == sze }.first["url"]
  end
end
