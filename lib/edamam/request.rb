require 'json'

class Request
  class << self
    def get_json(query, filters)
      url = "https://api.edamam.com/api/recipes/v2"
      type = "type=public"
      app_id = "app_id=bb5e4702"
      api_key = "app_key=7cb8c06cdedbc2d089957cc57703423c"
      query_string = query.nil? ? "" : query.map { |q| q + "%20" + "&" }.join("&")
      # filter_string = filters.nil? ? "" : filters.map { |k, v| "#{k}=#{v}" }.join("&")
      uri = "#{url}?#{type}&q=#{query_string}#{app_id}&#{api_key}"
      search_result = api(uri)
      JSON.parse (search_result.body), symbolize_names: true
    end

    def api(uri)
      HTTParty.get(uri, format: :plain)
    end
  end
end
