class Product < ApplicationRecord

  # Select Kroger product image perspective and size & return url
  def product_img(attr = {})
    per = attr[:perspective].downcase
    per_default = "front"
    sz = attr[:size]
    # sz_default = "thumbnail"

    if !images.detect { |p| p["perspective"] == per }.nil?
      perscpective_images = images.detect { |p| p["perspective"] == per }
    elsif
      perscpective_images = images.detect { |p| p["perspective"] == per_default }
    else
      perscpective_images = images.first
    end


    if !image = perscpective_images["sizes"].detect { |s| s["size"] == sz }.nil?
      image = perscpective_images["sizes"].detect { |s| s["size"] == sz }
    elsif
      image = perscpective_images["sizes"].last

    else
      image = "Error - BLANK"
    end

    unless image["url"].nil?
      image["url"]
    end
  end
end
