module RecipeFormHelper
  # Inserts correct form into recipe card
  def recipe_form(attrs = {})
    page_title = attrs[:page_title]
    erecipe_id = attrs[:erecipe_id]
    if page_title == "Course" || "Meal Planner"
      render 'courses/form', erecipe_id: erecipe_id
    elsif page_title == "Recipes"
      "More details"
    else
      "BLANK Footer Area"
    end
  end
end
