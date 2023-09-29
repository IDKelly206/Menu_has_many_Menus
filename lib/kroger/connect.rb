require 'json'

class Connect

  def self.api(query)
    products_url = 'https://api-ce.kroger.com/v1/products?'
    token = Token.get_token_request
    HTTParty.get(
      "#{products_url}#{query}",
      headers: {
      'Content-Type': "application/json",
      Authorization: "bearer #{token}"
      }
    )
  end

end
