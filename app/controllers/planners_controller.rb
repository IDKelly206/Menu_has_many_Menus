class PlannersController < ApplicationController
  before_action :set_meal_types
  before_action :set_course_types
  before_action :set_health_types
  before_action :set_household, only: [:index, :new, :create]
  before_action :set_meals, only: [:index]
  before_action :set_users, only: [:index]
  before_action :set_dietary_restrictions, only: [:index]
  before_action :set_menus, only: [:index]
  before_action :set_meal_type, only: [:index]
  before_action :set_course_type, only: [:index]

  def index
    @meal_ids = params[:meal_ids]

    s = { query: ["peach"], filters: { mealType: @meal_type, dishType: Course::DISH_TYPES[@course_type.to_sym], health: @dietary_restrictions } }
    results = Edamam::EdamamRecipe.search(s[:query], s[:filters])
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      @next_page = results[:next_page]
    end

  
  end

  def new
    @planner = PlannerForm.new
    calendar = Menu.calendar
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users
  end

  def create
    params[:planner_form].nil? ? @planner = PlannerForm.new : @planner = PlannerForm.new(planner_params)
    if @planner.submit
      meal_type = @planner.meal_type
      users = @planner.user_ids.map { |id| User.find(id) }
      menus = @planner.menu_ids.map { |id| Menu.find(id) }
      meal_ids = Meal.meal_ids(menus:, users:, meal_type:)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.adv_redirect(planners_path(meal_ids:))
        end
      end
    else
      calendar = Menu.calendar
      @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
      @users = @household.users
      render :new, status: :unprocessable_entity
    end

  end

  private

  def planner_params
    params.require(:planner_form).permit(:meal_type, user_ids: [], menu_ids: [])
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_health_types
    @health_types = Health::HEALTH_TYPES
  end

  def set_household
    @household = Household.find(current_user.household_id)
  end

  def set_meals
    @meals = params[:meal_ids].map { |id| Meal.find(id) }.flatten
  end

  def set_users
    @users = @meals.map { |meal| meal.user }.uniq
  end

  def set_dietary_restrictions
    @dietary_restrictions = @users.map { |u| u.dietary_restrictions }.flatten.map { |dr| dr.health.parameter }.uniq
  end

  def set_menus
    @menus = @meals.map { |meal| meal.menu }.uniq
  end

  def set_meal_type
    @meal_type = @meals.map { |meal| meal.meal_type }.uniq.first
  end

  def set_course_type
    params[:course_type].nil? ? @course_type = @course_types.first : @course_type = params[:course_type]
  end

end
