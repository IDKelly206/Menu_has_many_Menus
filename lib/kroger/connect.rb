require 'json'

class Connect
  formBody = "grant_type=client_credentials&scope=product.compact"

  TOKEN = fetch('https://api-ce.kroger.com/v1/connect/oauth2/token', {
    method: 'POST',
    headers:{
      'Content-Type': "application/x-www-form-urlencoded",
      'Authorization': "Basic #{ENV['api_base_64']}"
    },
    body: formBody
    })

  BASE = 'https://api-ce.kroger.com/v1/products'
  KEY = ENV['api_base_64']
  REQEUST = {
    method: 'GET',
    headers: {
      'Content-Type': "application/json",
      'Authorization': "Bearer #{TOKEN}"
    }
  }

  def self.api(query)
    fetch(BASE+"?"+query, REQUEST)
  end


end
