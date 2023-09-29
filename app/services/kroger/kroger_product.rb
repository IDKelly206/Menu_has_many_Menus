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
          brand: p[:brand]
        )
      end
    end
  end
end
