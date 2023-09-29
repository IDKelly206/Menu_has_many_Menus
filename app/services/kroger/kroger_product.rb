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
      response.fetch(:data).map do |p|
        Product.new(
          name:  p[:description],
          brand: p[:brand],
          upc: p[:upc],
          kproduct_id: p[:productId]
        )
      end
    end
  end
end
