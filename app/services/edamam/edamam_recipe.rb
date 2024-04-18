module Edamam
  require 'json'

  class EdamamRecipe
    attr_accessor :label,
                  :source,
                  :yield,
                  :image,
                  :ingredients

    def self.find(id)
      r = Request.get(id)
      if r.keys.include?(:status)
        r[:message]
      else
        label = label_scrub(r[:recipe][:label])
        Recipe.new(
                  label:       ,
                  source:      r[:recipe][:source],
                  source_url:  r[:recipe][:url],
                  yield:       r[:recipe][:yield],
                  image:       r[:recipe][:image],
                  images:      r[:recipe][:images],
                  ingredients: r[:recipe][:ingredients],
                  erecipe_id: id
                )
      end
    end

    def self.search(query = [], filters = {})
      response = Request.where(query, filters)
      if response.key?(:status)
        response[:message]
      else
        [recipes(response), next_page(response)]
      end
    end

    def self.recipes(response)
      response.fetch(:hits).map do |r|
        id_ing = "#{r[:_links][:self][:href]}".partition("v2/")
        id = id_ing[-1].partition("?").first
        label = label_scrub(r[:recipe][:label])
        Recipe.new(
          label: ,
          source:      r[:recipe][:source],
          source_url:  r[:recipe][:url],
          yield:       r[:recipe][:yield],
          image:       r[:recipe][:image],
          images:      r[:recipe][:images],
          ingredients: r[:recipe][:ingredients],
          erecipe_id: id
        )
      end
    end


    def self.next_page(response)
      response[:_links][:next]
    end

    # def self.next_recipes(href)
    #   resposne = href
    # end

    def self.update_recipes(url)
      uri = HTTParty.get(url, format: :plain)
      response = JSON.parse (uri.body), symbolize_names: true
      recipes(response)
    end

    def self.error_messages(response)
      hash = response.first
      message = []
      message << hash["errorCodde"]
      message << hash["message"]
      message.join(": ")
    end

    def self.label_scrub(name)
      name = name.split.map { |w| w.downcase.singularize }.join(' ')
      name.slice! 'recipe'
      name.split.map {|w| w.capitalize! }.join(' ')
    end
  end
end
