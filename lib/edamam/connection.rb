require 'json'

class Connection

  BASE = 'https://api.edamam.com/api/recipes/v2'
  KEY = "&"+ENV['app_id']+"&"+ENV['api_key']

  def self.api(path, option)
    option = option.empty? ? "" : "&#{option}"
    url = BASE+path+KEY+option
    HTTParty.get(url, format: :plain)
  end

end
