require 'json'

class RequestKroger
  class << self

    def where(query)
      query_full = query.first.split.join("%20")
      @query_full = query_full
      search = "filter.term=#{query_full}"
      location = "filter.locationId=01400943"
      fullfillment = "filter.fulfillment=ais"
      limit = "filter.limit=40"
      filters = [search, location, fullfillment, limit]
      full_query = filters.join("&")
      get_json(full_query)
    end

    def get_json(query)
      response = api(query)
      JSON.parse (response.body), symbolize_names: true
    end

    def api(query)
      Connect.api(query)
    end
  end
end
