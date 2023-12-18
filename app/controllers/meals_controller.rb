class MealsController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:index, :show]
  before_action :set_meal, only: [:index, :show]
  before_action :set_meal_types, only: [:index, :show, :meal_new, :new]
  before_action :set_course_types, only: [:index, :show, :new]



  def meal_new
    # Modal of GET form to meal#new. Selects multi-meal criteria
    calendar = (Time.now.to_date...(Time.now.to_date+10))
    @menus = Menu.where('household_id = ?', @household).where('date IN (:cal)', { cal: calendar })
    @users = @household.users

    @meal = Meal.new
    console
  end

  def new
    @recipes = Edamam::EdamamRecipe.search(params[:query], params[:filters])

    # Used to create multiple courses & provide erecipe_id for groceries
    @menus = params[:menu_ids].map { |menu_id| Menu.find(menu_id.to_i) }
    @users = params[:user_ids].map { |user_id| User.find(user_id.to_i) }
    @meal_type = params[:meal_type].capitalize
    @meal_ids = meal_ids(@menus, @users, @meal_type)

    # detect course(s) shared by all Meals.
    # @courses =

    @meals = @meal_ids.map { |meal| Meal.find(meal) }
    @meal_count = @meals.size

    #1 get all courses
    #2 filter to only those that share the same ?
    courses = []

    @meals.each do |meal|
      course_group = meal.courses.map { |course| Course.find(course.id) }
      courses.push(course_group)
    end

    @courses= courses.flatten

    courses_of_meal = {}

    @courses.each do |course|
      course_id = course.id
      recipe_id = course.erecipe_id
      if courses_of_meal[recipe_id].nil?
        courses_of_meal[recipe_id] = []
        courses_of_meal[recipe_id].push(course_id)
      else
        courses_of_meal[recipe_id].push(course_id)
      end
    end

    @courses_of_meal = courses_of_meal

    @recipes_with_course_id = courses_of_meal.select { |recipe_id, course_ids| course_ids.count == @meal_count }
    @recipe_ids = @recipes_with_course_id.keys
    course_list = []
    @recipe_ids.each_with_index do |recipe_id, index|
      recipe = Edamam::EdamamRecipe.find(recipe_id)
     if course_list[index].nil?
       course_list[index] = {}
       course_list[index][:label] = recipe.label
       course_list[index][:image] = recipe.image
       course_list[index][:erecipe_id] = recipe.erecipe_id
       course_list[index][:course_ids] = @recipes_with_course_id[recipe.erecipe_id]
       course_list[index][:course_type] = Course.find(course_list[index][:course_ids].first).course_type
     else
       course_list[index][:course_ids].push(@recipes_with_course_id[recipe.erecipe_id])
     end
    end

    @courses_final = course_list




    # @recipes_planned = @recipe_ids.map { |recipe_id| Edamam::EdamamRecipe.find(recipe_id) }


    # @recipes_hash = { :label, :image, :erecipe_id, course_ids: []}
    # @courses_array = []
    # @courses_hash = @recipes_planned.map { |recipe| label: recipe.label,
                                    # image: recipe.image,
                                    # erecipe_id: recipe.erecipe_id,
                                    # course_ids: @recipes_with_course_id[recipe.erecipe_id]
                                  # }



    # @recipe_ids = @courses.each { |course| course.erecipe_id }.uniq


    # 1 - get all recipes from courses
    # 2 - create hash of recipes with course_type & name
    # 3 - assign all course_ids for each recipe
    # 4 - delete_all Courses where id: id
      #  recipe_count = courses.each do |course|


      # end

    #  courses.select { |course| course.course_type == 'main course' && }

    console
  end


  def create
    @courses = Meal::Multicourse.create(course_params)
    course_ids = @courses.map { |course| course.id }
    # meal_ids = params[:meal_ids].first.split
    if @course_count == @new_courses
      redirect_to new_grocery_path(course_ids: course_ids), notice: "Course successfully added"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @courses = @meal.courses
    @recipes = @courses.map { |course| Edamam::EdamamRecipe.find(course.erecipe_id) }

    console
  end

  def destroy
    # Course.where(id: course_ids).destory_all
  end

  private

  def set_household
    @household = Household.find(current_user.id)
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_meal
    @meal = @menu.meals.find(params[:id])
  end

  def set_courses
  end

  def set_meal_types
    @meal_types = Meal::MEAL_TYPES
  end

  def set_course_types
    @course_types = Course::COURSE_TYPES
  end

  def course_params
    params.permit(:course_type, :erecipe_id, meal_ids: [])
  end

  def meal_ids(menus, users, meal_type)
    meals = []
    menus.each do |menu|
      users.each do |user|
        meal = Meal.where('user_id = ?', user.id).where('menu_id = ?', menu.id).where('meal_type = ?', meal_type).ids
        meals.push(meal)
      end
    end
    meals.flatten
  end
end
