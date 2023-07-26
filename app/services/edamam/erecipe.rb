module Edamam
  class Erecipe
    attr_accessor :label,
                  :source,
                  :yield




    def self.search(query = [], filters = {})
      response = Request.get_json(query, filters)
      response.fetch(:hits).map do |r|
        Erecipe.new(
                   label:     "#{r[:recipe][:label]}",
                   source:    "#{r[:recipe][:source]}",
                   yield:     "#{r[:recipe][:yield]}"
        )

      end
    end
  end
end
