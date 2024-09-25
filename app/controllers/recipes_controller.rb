class RecipesController < ApplicationController
  before_action :set_meal_types, only: [:index, :recipe_search]
  before_action :set_course_types, only: [:index, :recipe_search]
  before_action :set_dietary_filters, only: [:index, :recipe_search]
  before_action :set_recipe, only: [:show]


  def index
    if params[:query].present?
      results = Edamam::EdamamRecipe.search(params[:query], params[:filters])
      if results.keys.include?(:Status)
        redirect_to root_path, notice: "Recipe API error: " + @results
      else
        @recipes = results[:recipes]
        @next_page = results[:next_page]
      end
    else
      s = { query: ["peach"],
            filters: { "mealType" => "", "dishType" => "" }
          }
      results = Edamam::EdamamRecipe.search(s[:query], s[:filters])
      if results.keys.include?(:Status)
        redirect_to root_path, notice: "Recipe API error: " + @results
      else
        @recipes = results[:recipes]
        @next_page = results[:next_page]
      end
    end

    console
  end

  def show
  end

  def recipe_search
    query = params[:query]
    filters = params[:filters]
      unless filters["dishType"].empty?
        course_type = filters['dishType']
        dish_types = Course::DISH_TYPES[course_type.to_sym]
        filters["dishType"] = dish_types
      end
    filters
    results = Edamam::EdamamRecipe.search(query, filters)
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      @next_page = results[:next_page]
    end

    @title = params["title"]
    @course_type = params[:course_type].nil? ? params[:filters][:dishType] : params[:course_type]

    # Meal Planner params
    if params["meal_ids"].present?
      @meal_ids = params["meal_ids"]
    elsif params["menu_id"].present?
      @menu = Menu.find(params["menu_id"].to_i)
      @meal = Meal.find(params["meal_id"].to_i)
    end
  end

  private

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def set_dietary_filters
    @dietary_filters = Health::HEALTH_TYPES
  end

  def set_recipe
    recipe_id = params[:id]
    @result = Edamam::EdamamRecipe.find(recipe_id)
    if @result.instance_of?(Recipe)
      @recipe = @result
    else
      redirect_to root_path, notice: "Recipe API error: " + @result
    end
  end
end
