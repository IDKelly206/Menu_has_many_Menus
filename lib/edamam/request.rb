require 'json'

class Request
  class << self
    def get(id)
      type = "?type=public"
      path = "/#{id}#{type}"
      option = ""
      get_json(path, option)
    end

    def where(query, filters)
      type = "?type=public"
      query_string = query.nil? ? "" : query.first.split.join("%20")
      option = filters.nil? ? "" : filters.each.map { |k, v| v.class == Array ? v.join(' ').split(' ').map { |va| "#{k}=""#{va}".split.join("%20") } : "#{k}=#{v}".split.join("%20") }.join("&").insert(0, '&')
      path = "#{type}&q=#{query_string}"
      get_json(path, option)
    end

    def get_json(path, option)
      response = api(path, option)
      JSON.parse (response.body), symbolize_names: true
    end

    def api(path, option)
      Connection.api(path, option)
    end
  end
end
