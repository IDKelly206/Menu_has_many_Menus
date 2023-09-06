class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    # Recipe search criteria
    @meal_type = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]
    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    @next_page = Edamam::Erecipe.next_page



    console
  end

  def show
    @recipe = Edamam::Erecipe.find(@recipe_id)

    console
  end

  def new

    console
  end

  private
  def set_recipe
    @recipe_id = params[:id]
  end
end
