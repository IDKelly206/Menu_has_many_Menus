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
    elsif page_title == "Multi-Meal"
      render 'meals/form', erecipe_id: erecipe_id
    elsif page_title == "Recipe"
      "Recipes footer"
    else
      "BLANK Footer Area"
    #  Insert ingredients here. Need to fix Recipe.new for Search function
    end
  end

  def meal_ids(menus, users, meal_type)
    meals = []
    menus.each do |menu|
      users.each do |user|
        meal = Meal.where('user_id = ?', user.id).where('menu_id = ?', menu.id).where('meal_type = ?', "#{meal_type}").ids
        meals.push(meal)
      end
    end
    meals.flatten
  end



end
