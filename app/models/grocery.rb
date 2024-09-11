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
    # ingredient_names = groceries.map { |g_item| g_item.name.singularize.downcase }.uniq
    # grocery_list_names = []
    food_ids = groceries.map { |g_item| g_item.food_id }.uniq
    g_list_food_ids = []
    food_ids.each_with_index do |id, index|
      g_list_food_ids[index] = {}
      g_list_food_ids[index][:food_id] = id
      g_list_food_ids[index][:g_ids] = []
    end
    # ingredient_names.each_with_index do |name, index|
    #   grocery_list_names[index] = {}
    #   grocery_list_names[index][:n] = name.singularize.downcase
    #   grocery_list_names[index][:g_ids] = []
    # end

    groceries.each do |g|
      # name = g.name.singularize.downcase
      # g_item = grocery_list_names.detect { |i| i[:n] == name }
      food_id = g.food_id
      g_item = g_list_food_ids.detect { |i| i[:food_id] == food_id }
      g_item[:g_ids].push(g.id.to_s)
    end

    # grocery_list_names
    g_list_food_ids
  end

  def self.grocery_list(attrs = {} )
    recipe_ids = attrs[:recipe_ids]
    groceries = attrs[:groceries]
    grocery_list = attrs[:grocery_list]

    recipe_ids.each do |r|
      g_items_per_recipe = groceries.select { |g_item| g_item.erecipe_id == r }
      g_items_count = g_items_per_recipe.count
      g_items_uniq_count = g_items_per_recipe.map { |i| i.name }.uniq.count
      number_courses_per_recipe = (g_items_count / g_items_uniq_count)
      servings = groceries.detect { |g_item| g_item.erecipe_id == r }.erecipe_servings
      ingredient_multiplier = (number_courses_per_recipe / servings.to_f).ceil
      # ingredient_multiplier = 1


      g_items_per_recipe.each do |g_item|
        # name = g_item.name
        # unless grocery_list.detect { |list_item| list_item[:n] == name }.nil?
        food_id = g_item.food_id
        unless grocery_list.detect { |list_item| list_item[:food_id] == food_id }.nil?
          list_item = grocery_list.detect { |item| item[:food_id] == food_id }

          list_item[:n] = g_item.name.singularize.downcase if list_item[:n].nil?

          list_item[:cat] = []
          list_item[:cat].push(g_item.category) unless list_item[:cat].include?(g_item.category)

          list_item[:base_wgt_msr] = Converter::BASE_WGT_MSR if list_item[:base_wgt_msr].nil?
          if list_item[:base_wgt_qty].nil?
            list_item[:base_wgt_qty] = g_item.base_wgt_qty * ingredient_multiplier
          else
            list_item[:base_wgt_qty] += g_item.base_wgt_qty * ingredient_multiplier
          end

          unless g_item.base_vol_msr.blank?
            list_item[:base_vol_msr] = Converter::BASE_VOL_MSR if list_item[:base_vol_msr].nil?
            if list_item[:base_vol_qty].nil?
              list_item[:base_vol_qty] = g_item.base_vol_qty * ingredient_multiplier
            else
              list_item[:base_vol_qty] += g_item.base_vol_qty * ingredient_multiplier
            end
          end

          list_item[:q] += g_item.quantity * ingredient_multiplier if list_item[:m] == g_item.measurement

          if Converter::VOL_NAMES.keys.include?(g_item.measurement.to_sym) == Converter::WGT_NAMES.keys.include?(g_item.measurement.to_sym)
            list_item[:m] = g_item.measurement
            list_item[:q] = g_item.quantity
          end
        end
      end
    end

# PREVIOUS - start
    # recipes = []
    # # # Need to insert check if new ingredients before accessing API
    # recipe_ids.each do |recipe_id|
    #   recipe = Edamam::EdamamRecipe.find(recipe_id)
    #   recipes << recipe
    # end
    # recipes.each do |recipe|
    #   g_items_per_recipe = groceries.select { |g_item| g_item.erecipe_id == recipe.erecipe_id }
    #   g_items_count = g_items_per_recipe.count
    #   g_items_uniq_count = g_items_per_recipe.map { |i| i.name }.uniq.count

    #   number_courses_per_recipe = (g_items_count / g_items_uniq_count)
    #   servings = recipe.yield.to_f
    #   ingredient_multiplier = (number_courses_per_recipe / servings).ceil

    #   recipe.ingredients.each do |ingredient|
    #     # FILTER: not all ingredients, only those that are select to add
    #     name = ingredient["food"].singularize.downcase
    #     unless grocery_list.detect { |item| item[:n] == name }.nil?
    #       g_item = grocery_list.detect { |item| item[:n] == name }
    #       g_item[:cat] = g_item[:cat].nil? ? ingredient["foodCategory"] : g_item[:cat].include?(ingredient["foodCategory"]) ? g_item[:cat] : g_item[:cat] << ", #{ingredient["foodCategory"]}"

    #       g_item[:m] = ingredient["measure"] if g_item[:m].nil?
    #       g_item[:q].nil? ? g_item[:q] = (ingredient["quantity"] * ingredient_multiplier) : g_item[:q] += (ingredient["quantity"] * ingredient_multiplier)

    #       m = Converter.set_v_msr(m: ingredient["measure"])
    #       unless m.empty?
    #         q = (ingredient["quantity"] * ingredient_multiplier)
    #         base_v = Converter.v_to_base_v(m:, q:)
    #         g_item[:vol_q].nil? ? g_item[:vol_q] = base_v[:q] : g_item[:vol_q] += base_v[:q]
    #         g_item[:vol_m] = base_v[:m] if g_item[:vol_m].nil?
    #       end



    #       g_item[:wgt_q].nil? ? g_item[:wgt_q] = (ingredient["weight"] * ingredient_multiplier).round(2) : g_item[:wgt_q] += (ingredient["weight"] * ingredient_multiplier).round(2)
    #       g_item[:wgt_m].nil? ? g_item[:wgt_m] = 'g' : 'g'

    #       # Covert ingredient measure & quantity to base_msr with corresponding quantity
    #       # if volumes.includes?(ingredient["measure"])
    #       #   base_v = Covert.v_to_base_v(m: ingredient["measure"], q: (ingredient["quantity"] * ingredient_multiplier))
    #       #   g_item[:q].nil? ? g_item[:q] = base_v[:q] : g_item[:q] += base_v[:q]
    #       #   g_item[:m] = base_v[:m] if g_item[:m].nil?
    #       # elsif weights.include?(ingredient["measure"])
    #       #   base_w = Covert.w_to_base_w(m: ingredient["measure"], q: (ingredient["quantity"] * ingredient_multiplier))
    #       #
    #       # else
    #       #   g_item[:m] = ingredient["measure"]

    #     end
    #   end
    # end
# PREVIOUS - end

    # grocery_list.each { |item| item[:cat].uniq }
    # grocery_list.sort_by { |item| item[:cat] } --> Some missing category (ex. Guacomole)
    grocery_list
  end
end
