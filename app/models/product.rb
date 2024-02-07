class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def product_img(attr = {})
    per = attr[:perspective].downcase
    per_default = "front"
    sz = attr[:size]
    # sz_default = "thumbnail"

    if !images.detect { |p| p["perspective"] == per }.nil?
      perscpective_images = images.detect { |p| p["perspective"] == per }
    else
      perscpective_images = images.detect { |p| p["perspective"] == per_default }
    end

    image = perscpective_images["sizes"].detect { |s| s["size"] == sz }
    image["url"]
  end
end
