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
      Recipe.new(
                label:       r[:recipe][:label],
                source:      r[:recipe][:source],
                source_url:  r[:recipe][:url],
                yield:       r[:recipe][:yield],
                image:       r[:recipe][:image],
                images:      r[:recipe][:images],
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
          label:       r[:recipe][:label],
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

    def self.update_recipes(url)
      uri = HTTParty.get(url, format: :plain)
      response = JSON.parse (uri.body), symbolize_names: true
      recipes(response)
    end



    def self.grocery_list(attrs = {} )
      ids = attrs[:ids]
      groceries = attrs[:groceries]
      grocery_list = attrs[:grocery_list]
      recipes = []
      ids.each do |recipe_id|
        recipe = Edamam::EdamamRecipe.find(recipe_id)
        recipes << recipe
      end
      recipes.each do |recipe|
        g_items_per_recipe = groceries.select { |g_item| g_item.erecipe_id == recipe.erecipe_id }
        g_items_count = g_items_per_recipe.count
        g_items_uniq_count = g_items_per_recipe.map { |i| i.name }.uniq.count

        number_courses_per_recipe = (g_items_count / g_items_uniq_count)
        servings = recipe.yield.to_f
        ingredient_multiplier = (number_courses_per_recipe / servings).ceil

        recipe.ingredients.each do |ingredient|
          # FILTER: not all ingredients, only those that are select to add
          name = ingredient["food"].singularize.downcase
          unless grocery_list.detect { |item| item[:n] == name }.nil?
            g_item = grocery_list.detect { |item| item[:n] == name }
            g_item[:m] = ingredient["measure"] if g_item[:m].nil?
            g_item[:q].nil? ? g_item[:q] = (ingredient["quantity"] * ingredient_multiplier) : g_item[:q] += (ingredient["quantity"] * ingredient_multiplier)
            g_item[:cat] = ingredient["foodCategory"] if g_item[:cat].nil?
          end
        end
      end
      grocery_list
    end



  end
end
