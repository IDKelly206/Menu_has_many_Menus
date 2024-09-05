class Grocery::Importer
  include Converter

  def self.create(grocery_params)
    new(grocery_params).create(grocery_params)
  end

  def initialize(grocery_params)
    @household = Household.find(grocery_params.fetch(:household_id).to_i)
    @courses = grocery_params.fetch(:course_ids).split.map { |id| Course.find(id) }
    @erecipe_id = grocery_params.fetch(:erecipe_id)

    @name = grocery_params.fetch(:name).gsub(/[-()]/, " ")
    @quantity = grocery_params.fetch(:quantity).to_f.round(2)
    @measurement = Converter.set_msr_name(m: grocery_params.fetch(:measurement))
    @category = grocery_params.fetch(:category)
    @list_add = grocery_params.fetch(:list_add).to_i
  end

  def create(grocery_params)
    validate_params!

    @glist_count = 0
    @glist_count += @list_add
    @new_glist = 0

    if grocery_params.fetch(:list_add).to_i >= 1
      @courses.each do |course|
        Grocery.create!(
          household: @household,
          course: course,
          name: @name.downcase,
          quantity: @quantity,
          measurement: @measurement.downcase,
          category: @category.downcase,
          erecipe_id: @erecipe_id
        )
      end
      @new_glist += 1
    end
  end

  def validate_params!
    raise "Invalid params" unless @household.present?
    raise "Invalid params" unless @courses.present?
    raise "Invalid params" unless @name.present?
    raise "Invalid params" unless @quantity.present?
    raise "Invalid params" unless @measurement.present?
    raise "Invalid params" unless @category.present?
    raise "Invalid params" unless @erecipe_id.present?
  end
end
