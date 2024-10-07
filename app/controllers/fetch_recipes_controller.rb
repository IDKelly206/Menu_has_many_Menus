class FetchRecipesController < ApplicationController
  def index
    href = params[:href]
    @title = params[:title]
    results = Edamam::EdamamRecipe.update_recipes(href)
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      @next_page = results[:next_page] unless results[:next_page].nil?
    end
  end
  def search
    href = params[:href]
    @title = params[:title]
    results = Edamam::EdamamRecipe.update_recipes(href)
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      @next_page = results[:next_page] unless results[:next_page].nil?
    end
    respond_to do |format|
      format.turbo_stream {}
    end
  end
end
