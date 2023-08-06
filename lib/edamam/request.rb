require 'json'

class Request
  class << self
    def get_json(query)
      type = "type=public"
      query_string = query.nil? ? "" : query.first.split.join("%20")
      # filter = filters.nil? ? "" : filters.each.map { |k, v| "#{k}=""#{v}".split.join("%20") }.join("&").insert(0, '&')
      path = "#{type}&q=#{query_string}"
      response = api(path)
      JSON.parse (response.body), symbolize_names: true
    end

    def api(path)
      Connection.api(path)
    end
  end
end
