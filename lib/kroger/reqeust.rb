require 'json'

class Request
  class << self

    def get_json(query)
      response = api(query)
      JSON.parse (response.body), symbolize_names: true
    end

    def api(query)
      Connect.api(query)
    end
  end
end
