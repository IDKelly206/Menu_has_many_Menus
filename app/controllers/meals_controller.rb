class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]



  def meal_new
    calendar = (Time.now.to_date...(Time.now.to_date+10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = User.all.where(household_id: @household)
    @meal_types = %w(Breakfast Lunch Dinner)

    console
  end

  def new
    # Meal ID criteria
    @menu_ids = params.fetch(:menu_ids, []) if params.fetch(:menu_ids, []).present?
    @user_ids = params.fetch(:user_ids, []) if params.fetch(:menu_ids, []).present?
    @meal_types = params.fetch(:meal_type, "") if params.fetch(:menu_ids, []).present?

    if !@menu_ids.nil? && !@user_ids.nil? && !@meal_types.nil?
      @meals = []
      @menu_ids.each do |menu_id|
        @user_ids.each do |user_id|
          meal = Meal.where(user_id: user_id).where(menu_id: menu_id).where(meal_type: @meal_types).ids
          @meals.push(meal)
        end
      end
      @meals.flatten!
    end

    # @meals = [1032, 1086, 1074, 1107]

    # Search criteria
    @meal_type = ["Breakfast", "Lunch", "Dinner"]
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    #
    @meal = Course.new

    console
  end


  def create

    Meal::Multicourse.create(course_params)

    if @course_count == @new_courses
      redirect_to new_meal_path, notice: "Meal(s) were successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end


  def show
    @courses = @meal.courses

    console
  end

  private

  def set_household
    @household = current_user.household_id
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:id])
  end

  def course_params
    params.permit(:course_type, :erecipe_id, meal_ids: [])
  end

  def meal_params
    params.permit(:meal_type, user_ids: [], menu_ids: [])
  end
end


#  MEAL creation function with COURSE
# menu_ids.each do |menu_id|
#   menu = Menu.find(menu_id)
#     user_ids.each do |user_id|
#       Meal.create!(meal_type: meal_type, user_id: user_id, menu_id: menu_id)
#       meal_id = Meal.last.id
#       courses_info.each do |course|
#         Course.create!(meal_id: meal_id, course_type: course[0], recipe_id: course[1])
#       end
#     end
# end
#
