class Meal::Importer

  def self.create(meal_params)
    new(meal_params).create(meal_params)
  end

  def initialize(meal_params)
    @menu_ids = meal_params.fetch(:menu_ids, [])
    @user_ids = meal_params.fetch(:user_ids, [])
    @meal_type = meal_params.fetch(:name, "")
  end

  def create
    validate_params!

    @menu_ids.each do |menu_id|
      menu = Menu.find(menu_id)
      @user_ids.each do |user_id|
        Meal.create!(name: @meal_type, user_id: user_id, menu_id: menu_id)
      end
    end
  end

  def validate_params!
    raise "Invalid params: Meal type" unless @meal_type.present?
    raise "Invalid params: Menu id" unless @menu_ids.present?
    raise "Invalid params: User id" unless @user_ids.present?
  end
end
