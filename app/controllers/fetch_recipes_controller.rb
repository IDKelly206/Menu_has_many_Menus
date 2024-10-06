class FetchRecipesController < ApplicationController
  def index
    href = params[:href]
    @title = params[:title]
    results = Edamam::EdamamRecipe.update_recipes(href)
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      unless results[:next_page].nil?
        @next_page = results[:next_page]
        # render partial: "fetch_recipes/scrollable_list, locals: { title: @title }"
      end
      console
    end


  end
  def search
    # Need data:
    # course_type
    # title cycled
    href = params[:href]
    @title = params[:title]
    results = Edamam::EdamamRecipe.update_recipes(href)
    if results.keys.include?(:Status)
      redirect_to root_path, notice: "Recipe API error: " + @results
    else
      @recipes = results[:recipes]
      unless results[:next_page].nil?
        @next_page = results[:next_page]
        # render :scrollable_list
      end

    end
    respond_to do |format|
      format.turbo_stream { }
    end
  end
end
