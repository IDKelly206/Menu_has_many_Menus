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

# type=public&q=oatmeal%20peach  = PATH
# &app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c
# &health=vegan&mealType=Breakfast&dishType=Main%20course
