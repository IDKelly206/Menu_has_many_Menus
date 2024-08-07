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
      path = "#{type}&q=#{query_string}"

      # option = filters.each.map { |k, v| v.empty? ? "" : v.class == Array ? v.join(' ').split(' ').map { |va| "#{k}=""#{va}".split.join("%20") } : "#{k}=#{v}".split.join("%20") }.join("&").insert(0, '&')

      option = []
      filters.each do |k, v|
        unless v.empty?
          if v.class == Array
            opt = v.join(' ').split(' ').map { |va| "#{k}=""#{va}".split.join("%20") }
            option << "&" + opt.join("&")
          else
            opt = "#{k}=#{v}".split.join("%20")
            option << "&" + opt
          end
        end
      end
      option = option.join("")

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

# type=public&q=oatmeal%20peach  = PATH
# &app_id=bb5e4702&app_key=7cb8c06cdedbc2d089957cc57703423c
# &health=vegan&mealType=Breakfast&dishType=Main%20course
# health=vegan&health=vegetarian&mealType=Breakfast&dishType=Main%20course
