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
        if p[:brand].nil?
          name = p[:description]
        else
          name = my_strip(p[:description], p[:brand]).nil? ? p[:description] : my_strip(p[:description], p[:brand])
        end

        Product.new(
          name:,
          brand: p[:brand],
          upc: p[:upc],
          kproduct_id: p[:productId],
          item_info: p[:items],
          aisle: p[:categories],
          images: p[:images]
        )
      end
    end

    def self.my_strip(string, chars)
      chars = Regexp.escape(chars)
      string.gsub(/\A[#{chars}]+|[#{chars}]+\z/, "")
    end

  end
end
