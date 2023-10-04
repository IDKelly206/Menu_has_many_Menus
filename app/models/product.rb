class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def kroger_img(perspective, size )
    front_img = self.images.select { |p| p["perspective"] == "#{perspective}" }
    front_img.first["sizes"].select { |s| s["size"] == "#{size}" }.first["url"]
  end
end
