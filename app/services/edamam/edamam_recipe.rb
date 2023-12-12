module Edamam
  require 'json'

  class EdamamRecipe
    attr_accessor :label,
                  :source,
                  :yield,
                  :image

    def self.find(id)
      r = Request.get(id)
      Recipe.new(
                label:     r[:recipe][:label],
                source:    r[:recipe][:source],
                yield:     r[:recipe][:yield],
                image:     r[:recipe][:image],
                ingredients: r[:recipe][:ingredients],
                erecipe_id: id
              )
    end


    def self.search(query = [], filters = {})
      response = Request.where(query, filters)
      @response = response
      recipes(response)
    end

    def self.next_page
      @response[:_links][:next]
    end

    def self.recipes(response)
      response.fetch(:hits).map do |r|
        id_ing = "#{r[:_links][:self][:href]}".partition("v2/")
        id = id_ing[-1].partition("?").first
        Recipe.new(
          label:     r[:recipe][:label],
          source:    r[:recipe][:source],
          yield:     r[:recipe][:yield],
          image:     r[:recipe][:image],
          ingredients: r[:recipe][:ingredients],
          erecipe_id: id
        )
      end
    end

    def self.update_recipes(url)
      uri = HTTParty.get(url, format: :plain)
      response = JSON.parse (uri.body), symbolize_names: true
      recipes(response)
    end
  end
end
