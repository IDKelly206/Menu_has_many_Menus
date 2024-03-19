module Kroger
  require 'json'

  class KrogerProduct
    attr_accessor :name,
                  :brand

    def self.search(query)
      response = RequestKroger.where(query)
      products(response)
    end

    def self.products(response)
      @response = response
      response.fetch(:data).map do |p|
        Product.new(
          name:p[:description],
          brand: p[:brand],
          upc: p[:upc],
          kproduct_id: p[:productId],
          item_info: p[:items],
          aisle: p[:categories],
          images: p[:images]
        )
      end
    end

    # def self.strip_phrase(attr = {})
    #   brand = attr[brand:].downcase
    #   description = attr[description:].downcase
    #   name = description.split! brand
    #   name.strip!.split.each {|w| w.capitalize!}.join(" ")
    #   # chars = Regexp.escape(brand).downcase
    #   # string = Regexp.escape(description.downcase)
    #   # name_split = string.sub(chars, '')
    #   # string.gsub(/\A[#{chars}]+|[#{chars}]+\z/, "")
    # end

  end
end
