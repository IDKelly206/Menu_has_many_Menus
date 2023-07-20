module Edamam
  class Erecipe
    attr_accessor :label, :source, :yield

    def self.search(query)
      response = Request.get_json(query)
      recipes = response.fetch(:hits).map do |r|
        Recipe.new(
                   label: "#{r[:recipe][:label]}",
                   source: "#{r[:recipe][:source]}",
                   yield: "#{r[:recipe][:yield]}"
          )
        end

    end
  end
end
