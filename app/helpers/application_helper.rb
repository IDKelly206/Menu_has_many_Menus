module ApplicationHelper
  # Returns the full title on a per-page basis
  def title(page_title)
    content_for(:title) { page_title }
  end

  # Inserts correct form into recipe card
  def recipe_form(attrs = { } )
    page_title = attrs[:page_title]
    erecipe_id = attrs[:erecipe_id]
    if page_title == "Course"
      render 'courses/form', erecipe_id: erecipe_id
    elsif page_title == "Meal Planner"
      render 'meals/form', erecipe_id: erecipe_id
    elsif page_title == "Recipes"
      # render 'meals/link', erecipe_id: erecipe_id
      # "More details"
    else
      "BLANK Footer Area"
    #  Insert ingredients here. Need to fix Recipe.new for Search function
    end
  end

  
end
