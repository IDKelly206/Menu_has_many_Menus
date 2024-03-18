require 'json'

class Connect

  def self.api(query)
    products_url = 'https://api-ce.kroger.com/v1/products?'

    # response = Token.get_token_request
    # token = response[:token_type]+" "+response[:access_token]
    # @time_limit = response[:expires_in]
    # @token_request_time = Time.now
    # #request products
    # HTTParty.get(
    #   "#{products_url}#{query}",
    #   headers: {
    #   'Content-Type': "application/json",
    #   Authorization: "#{token}"
    #   }
    # )

    if (defined? @token).nil?
      response = Token.get_token_request
      @token = response[:token_type]+" "+response[:access_token]
      @time_limit = response[:expires_in]
      @token_request_time = Time.now
      HTTParty.get(
        "#{products_url}#{query}",
        headers: {
        'Content-Type': "application/json",
        Authorization: "#{@token}"
        }
      )
    elsif Time.now - @token_request_time < @time_limit
      # request products w/ existing token
      HTTParty.get(
        "#{products_url}#{query}",
        headers: {
        'Content-Type': "application/json",
        Authorization: "#{@token}"
        }
      )
    else
      # Get new token b/c time expired
      response = Token.get_token_request
      @token = response[:token_type]+" "+response[:access_token]
      @time_limit = response[:expires_in]
      @token_request_time = Time.now
      # request products
      HTTParty.get(
        "#{products_url}#{query}",
        headers: {
        'Content-Type': "application/json",
        Authorization: "#{token}"
        }
      )
    end






  end
end
