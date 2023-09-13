class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    # Recipe search criteria
    @meal_types = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Starter", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]
    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])

    # render @recipes, partial: 'recipes/recipe'

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
