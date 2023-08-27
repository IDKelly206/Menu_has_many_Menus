

class RecipesController < ApplicationController

  def index
    console
  end

  def show
    @recipe = Edamam::Erecipe.find(params[:id])
    
    console
  end

  def new

    @meal_type = %w(Breakfast Lunch Dinner)
    @dish_type = ["Main course", "Side dish", "Desserts"]
    @health = ["vegan", "vegetarian", "paleo"]

    @recipes = Edamam::Erecipe.search(params[:query], params[:filters])
    @next_page = Edamam::Erecipe.next_page
    console

  end
end
