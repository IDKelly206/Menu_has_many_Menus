require 'json'

class Token
  def self.get_token_request
    formBody = "grant_type=client_credentials&scope=product.compact"
    token_url = 'https://api-ce.kroger.com/v1/connect/oauth2/token'
    response_token = HTTParty.post(
                      token_url,
                      body: formBody,
                      headers: {
                        'Content-Type': "application/x-www-form-urlencoded",
                        'Authorization': "Basic #{ENV['api_base_64']}"
                      },
                      format: :plain
                    )

    response = JSON.parse (response_token.body), symbolize_names: true
    # @token = response[:access_token]
  end


end
