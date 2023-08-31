class Grocery::Importer
  def self.create(grocery_params)
    new(grocery_params).create(grocery_params)
  end

  def initialize(grocery_params)
    @household_id = grocery_params.fetch(:household_id).to_i
    @name = grocery_params.fetch(:name)
    @quantity = grocery_params.fetch(:quantity).to_i
    @measurement = grocery_params.fetch(:measurement)
    @category = grocery_params.fetch(:category)
    @erecipe_id = grocery_params.fetch(:erecipe_id)
    @list_add = grocery_params.fetch(:list_add).to_i
  end

  def create(grocery_params)
    validate_params!

    @glist_count = 0
    @glist_count += @list_add
    @new_glist = 0

    if grocery_params.fetch(:list_add).to_i >= 1
      Grocery.create!(
        household_id: @household_id,
        name: @name,
        quantity: @quantity,
        measurement: @measurement,
        category: @category,
        erecipe_id: @erecipe_id
      )
      @new_glist += 1
    end

  end

  def validate_params!
    raise "Invalid params" unless @household_id.present?
    raise "Invalid params" unless @name.present?
    raise "Invalid params" unless @quantity.present?
    raise "Invalid params" unless @measurement.present?
    raise "Invalid params" unless @category.present?
    raise "Invalid params" unless @erecipe_id.present?
  end

end
