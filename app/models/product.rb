class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def product_img(attr = {})
    per = attr[:perspective].downcase
    sz = attr[:size]
    perscpective_images = self.images.detect { |p| p["perspective"] == per }
    image = perscpective_images["sizes"].detect { |s| s["size"] == sz }
    image["url"]
  end
end
