class Grocery::Importer
  include Converter

  def self.create(grocery_params)
    new(grocery_params).create(grocery_params)
  end

  def initialize(grocery_params)
    @household = Household.find(grocery_params.fetch(:household_id).to_i)
    @courses = grocery_params.fetch(:course_ids).split.map { |id| Course.find(id) }
    # @menus = grocery_params.fetch(:menu_ids).split.uniq.map { |id| Menu.find(id) }

    @name = grocery_params.fetch(:name).gsub(/[-()]/, " ").downcase.singularize
    @category = grocery_params.fetch(:category).downcase

    msr = grocery_params.fetch(:measurement).gsub(/<>]/, " ").downcase.singularize
    @measurement = Converter.set_msr_name(m: msr)
    @quantity = grocery_params.fetch(:quantity).to_f.round(2)

    @food_id = grocery_params.fetch(:food_id)

    @erecipe_id = grocery_params.fetch(:erecipe_id)
    @erecipe_servings = grocery_params.fetch(:erecipe_servings).to_i

    if Converter::VOL_NAMES.keys.include?(@measurement.to_sym)
      @base_vol_qty = Converter.v_to_base_v(m: @measurement, q: @quantity).to_f.round(2)
      @base_vol_msr = Converter::BASE_VOL_MSR
    else
      @base_vol_qty = nil
      @base_vol_msr = nil
    end

    @base_wgt_qty = grocery_params.fetch(:base_wgt_qty).to_f.round(2)
    @base_wgt_msr = grocery_params.fetch(:base_wgt_msr)

    @list_add = grocery_params.fetch(:list_add).to_i
  end

  def create(grocery_params)
    validate_params!

    if grocery_params.fetch(:list_add).to_i >= 1
      @courses.each do |course|
        Grocery.create!(
          household: @household,
          course: course,
          menu_id: course.meal.menu.id,
          name: @name,
          quantity: @quantity,
          measurement: @measurement,
          category: @category,
          erecipe_id: @erecipe_id,
          erecipe_servings: @erecipe_servings,
          base_vol_qty: @base_vol_qty,
          base_vol_msr: @base_vol_msr,
          base_wgt_qty: @base_wgt_qty,
          base_wgt_msr: @base_wgt_msr,
          food_id: @food_id
        )
      end
    end
  end

  def validate_params!
    raise "Invalid params" unless @household.present?
    raise "Invalid params" unless @courses.present?
    # raise "Invalid params" unless @menus.present?
    raise "Invalid params" unless @name.present?
    raise "Invalid params" unless @quantity.present?
    raise "Invalid params" unless @measurement.present?
    raise "Invalid params" unless @category.present?
    raise "Invalid params" unless @erecipe_id.present?
  end
end
