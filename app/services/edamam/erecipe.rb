module Edamam
  class Erecipe
    attr_accessor :label,
                  :source,
                  :yield,
                  :image

    def self.find(id)
      r = Request.get(id)
      # recipe[:recipe][:uri]
      Recipe.new(
                label:     r[:recipe][:label],
                source:    r[:recipe][:source],
                yield:     r[:recipe][:yield],
                image:     r[:recipe][:image],
                erecipe_id: id
                )

    end


    def self.search(query = [], filters = {})
      response = Request.where(query, filters)
      response.fetch(:hits).map do |r|
        id_ing = "#{r[:_links][:self][:href]}".partition("v2/")
        id = id_ing[-1].partition("?").first
        Recipe.new(
                  label:     "#{r[:recipe][:label]}",
                  source:    "#{r[:recipe][:source]}",
                  yield:     "#{r[:recipe][:yield]}",
                  image:     "#{r[:recipe][:image]}",
                  erecipe_id: "#{id}"
                  )
      end
    end



  end
end
