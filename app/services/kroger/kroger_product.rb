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
          name:  p[:description],
          brand: p[:brand],
          upc: p[:upc],
          kproduct_id: p[:productId],
          item_info: p[:items],
          aisle: p[:categories],
          images: p[:images].first
        )
      end
    end
  end
end
