class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def product_img(attr = {})
    per = attr[:perspective]
    sz = attr[:size]
    images = self.images.select { |p| p["perspective"] == per }
    images.first["sizes"].select { |s| s["size"] == sz }.first["url"]
  end
end
