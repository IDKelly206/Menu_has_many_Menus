require 'json'

class Connection

  BASE = 'https://api.edamam.com/api/recipes/v2'

  app_id = "app_id=bb5e4702"
  api_key = "app_key=7cb8c06cdedbc2d089957cc57703423c"
  KEY = "&#{app_id}&#{api_key}"



  def self.api(path)
    uri = BASE+"?"+path+KEY
    HTTParty.get(uri, format: :plain)
  end

end
