class PlannersController < ApplicationController
  before_action :set_household, only: [:index, :new, :create]
  before_action :set_meal_types
  before_action :set_course_types
  before_action :set_meal_type, only: [:index]
  before_action :set_course_type, only: [:index]
  before_action :set_menus, only: [:index]
  before_action :set_users, only: [:index]

  def index
    @meals = Meal.meals(menus: @menus, users: @users, meal_type: @meal_type)
    @meal_ids = @meals.map { |m| m.id }
    @dietary_restrictions = @users.map { |u| u.dietary_restrictions }.flatten.map { |dr| dr.health.parameter }.uniq
    params[:course_ids].nil? ? @course_ids = [] : @course_ids = params[:course_ids]

    s = { query: ["egg"], filters: { mealType: 'lunch', dishType: 'main course' } }
    @results = Edamam::EdamamRecipe.search(s[:query], s[:filters])
    if @results.instance_of?(Array)
      @recipes = @results.first
      @next_page = @results.last

    else
      redirect_to root_path, notice: "Recipe API error: " + @results
    end
    # @recipes = []


    #  FORM object


    #  For rendering course cards in search bar for meals selected
    course_groups = []
    @meals.each { |meal| course_groups.push(meal.courses.map { |course| Course.find(course.id) }) }
    courses_all = course_groups.flatten
    courses_of_meals = {}
    courses_all.each do |course|
      course_id = course.id
      recipe_id = course.erecipe_id
      if courses_of_meals[recipe_id].nil?
        courses_of_meals[recipe_id] = []
        courses_of_meals[recipe_id].push(course_id)
      else
        courses_of_meals[recipe_id].push(course_id)
      end
    end
    courses_of_meals
    @recipes_with_course_id = courses_of_meals.select { |recipe_id, course_ids| course_ids.count == @meals.size }
    @courses = @recipes_with_course_id.keys.map { |recipe_id| courses_all.detect { |course| course.erecipe_id == recipe_id } }
    @course_recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end

  def new
    @planner = PlannerForm.new

    calendar = (Time.now.to_date...(Time.now.to_date + 10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users

    console
  end

  def create
    @planner = params[:planner_form].nil? ? @planner = PlannerForm.new : PlannerForm.new(planner_params)

    if @planner.submit
      meal_type = @planner.meal_type
      user_ids = @planner.user_ids
      menu_ids = @planner.menu_ids
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.adv_redirect(planners_path(meal_type:, user_ids:, menu_ids:))
        end
        format.html { redirect_to planners_path(meal_type:, user_ids:, menu_ids:) }
      end
    else

      calendar = (Time.now.to_date...(Time.now.to_date + 10))
      @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
      @users = @household.users

      render :new, status: :unprocessable_entity
    end
    console
  end

  private

  def planner_params
    params.require(:planner_form).permit(:meal_type, user_ids: [], menu_ids: [])
  end

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_meal_type
    @meal_type = params[:meal_type]
  end

  def set_course_type
    params[:course_type].nil? ? @course_type = @course_types.first : @course_type = params[:course_type]
  end

  def set_users
    @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
  end

  def set_menus
    @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
  end
end
