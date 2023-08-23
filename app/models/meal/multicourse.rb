class Meal::Multicourse
  def self.create(meal_params)
    new(meal_params).create(meal_params)
  end


  def initialize(meal_params)
    @menu_ids = meal_params.fetch(:menu_ids, [])
    @user_ids = meal_params.fetch(:user_ids, [])
    @meal_type = meal_params.fetch(:meal_type, "")
  end

  def create(meal_params)
    validate_params!

    @meal_count = @menu_ids.count * @user_ids.count
    @new_meals = 0

    @menu_ids.each do |menu_id|
      @user_ids.each do |user_id|
        Meal.create!(meal_type: @meal_type, user_id: user_id, menu_id: menu_id)
        @new_meals += 1
      end
    end
  end

  def create(meal_params)
    validate_params!

    @meal_count = @menu_ids.count * @user_ids.count
    @new_meals = 0

    @menu_ids.each do |menu_id|
      @user_ids.each do |user_id|
        Meal.create!(meal_type: @meal_type, user_id: user_id, menu_id: menu_id)
        @new_meals += 1
      end
    end
  end

  def validate_params!
    # raise "Invalid params" unless @meal_type.present?
    # raise "Invalid params" unless @menu_ids.present?
    # raise "Invalid params" unless @user_ids.present?
  end
end
