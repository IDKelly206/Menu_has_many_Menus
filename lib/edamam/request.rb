require 'json'

class Request
  class << self
    def get_json(query = [])
      url = "https://api.edamam.com/api/recipes/v2?type=public&q="
      app_id = "app_id=bb5e4702";
      api_key = "app_key=7cb8c06cdedbc2d089957cc57703423c";
      query_string = query.map { |q| q + "%20" + "&" }.join
      uri = url + query_string + app_id + "&"+ api_key
      search_result = HTTParty.get(uri, format: :plain)
      JSON.parse (search_result.body), symbolize_names: true
    end

    def api(uri)
      HTTParty.get(uri)
    end
  end
end
