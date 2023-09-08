module ApplicationHelper

# Returns the full title on a per-page basis

  # Access page titles
  def title(page_title)
    content_for(:title) { page_title }
  end

  # Inserts correct form into recipe card
  def recipe_form(page_title = '', erecipe_id = '')
    if page_title == "Course"
      render 'courses/form', erecipe_id: erecipe_id
    elsif page_title == "Mulit-Meal"
      render 'meals/form', erecipe_id: erecipe_id
    else
      "BIG Footer Area"
    #  Insert ingredients here. Need to fix Recipe.new for Search function
    end
  end


end
