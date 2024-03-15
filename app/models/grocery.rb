class Grocery < ApplicationRecord
  belongs_to :household
  belongs_to :course

  validates :name, presence: true
  validates :quantity, presence: true
  validates :measurement, presence: true
  validates :erecipe_id, presence: true
  validates :course_id, presence: true

  include Converter

  # Add ordered sequence of :foodCat then :name
  # scope :ordered, -> { order(name: :asc)}

  def self.groceries(household)
    household.groceries.select { |g| g if g.list_add == true }
  end

  def self.grocery_hash(groceries)
    ingredient_names = groceries.map { | g_item | g_item.name.singularize.downcase }.uniq
    grocery_list_names = []
    ingredient_names.each_with_index do |name, index|
      grocery_list_names[index] = {}
      grocery_list_names[index][:n] = name.singularize.downcase
      grocery_list_names[index][:g_ids] = []
    end

    groceries.each do |g|
      name = g.name.singularize.downcase
      g_item = grocery_list_names.detect { |i| i[:n] == name }
      g_item[:g_ids].push(g.id.to_s)
    end

    grocery_list_names
  end

  def self.grocery_list(attrs = {} )
    recipe_ids = attrs[:recipe_ids]
    groceries = attrs[:groceries]
    grocery_list = attrs[:grocery_list]
    recipes = []
    # Need to insert check if new ingredients before accessing API
    recipe_ids.each do |recipe_id|
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
          g_item[:cat] = g_item[:cat].nil? ? ingredient["foodCategory"] : g_item[:cat].include?(ingredient["foodCategory"]) ? g_item[:cat] : g_item[:cat] << ", #{ingredient["foodCategory"]}"

          # g_item[:m] = ingredient["measure"] if g_item[:m].nil?

          # g_item[:q].nil? ? g_item[:q] = (ingredient["quantity"] * ingredient_multiplier) : g_item[:q] += (ingredient["quantity"] * ingredient_multiplier)


          m = Converter.set_v_msr(m: ingredient["measure"])
          q = (ingredient["quantity"] * ingredient_multiplier)
          base_v = Converter.v_to_base_v(m:, q:)
          g_item[:q].nil? ? g_item[:q] = base_v[:q] : g_item[:q] += base_v[:q]
          g_item[:m] = base_v[:m] if g_item[:m].nil?


          # Covert ingredient measure & quantity to base_msr with corresponding quantity
          # if volumes.includes?(ingredient["measure"])
          #   base_v = Covert.v_to_base_v(m: ingredient["measure"], q: (ingredient["quantity"] * ingredient_multiplier))
          #   g_item[:q].nil? ? g_item[:q] = base_v[:q] : g_item[:q] += base_v[:q]
          #   g_item[:m] = base_v[:m] if g_item[:m].nil?
          # elsif weights.include?(ingredient["measure"])
          #   base_w = Covert.w_to_base_w(m: ingredient["measure"], q: (ingredient["quantity"] * ingredient_multiplier))
          #
          # else
          #   g_item[:m] = ingredient["measure"]

        end
      end
    end
    # grocery_list.each { |item| item[:cat].uniq }
    grocery_list.sort_by { |item| item[:cat] }
  end




end
