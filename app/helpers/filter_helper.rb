module FilterHelper
  def filter_types(attr = { })
    unless attr[:type].nil?
      type = attr[:type]
      pills = "<li class='btn--pill btn--pill--meal'>#{type.capitalize}</li>"
      pills.html_safe
    end
  end

  def filter_users(attr = {})
    unless attr[:users].nil?
      users = attr[:users]
      if users.class == Array
        pills = users.map { |u| "<li class='btn--pill btn--pill--user'>#{u.name_first}</li>" }
        pill = pills.join(' ')
      else
        pill = "<li class='btn--pill btn--pill--user'>#{users.name_first}</li>"
      end
      pill.html_safe
    end
  end

  def filter_dates(attr = {})
    unless attr[:dates].nil?
      menus = attr[:dates]
      if menus.class == Array
        pills = menus.map { |m| "<li class='btn--pill btn--pill--date'>#{m.day_of_week}</li>" }
        pill = pills.join(' ')
      else
        pill = "<li class='btn--pill btn--pill--date'>#{menus.day_of_week}</li>"
      end
      pill.html_safe
    end
  end

  def select_mealtypes(ft , attr = {})
    type = attr[:type]
    types = attr[:types]
    pills = ''
    if type.nil?
      pills << "<div class='radio-btns'>"
      types.map do |t|
        pills << "<div class='radio-item'>
                #{ft.radio_button :mealType, t, class: 'radio-btn btn--pill btn--pill--meal'}"
        pills << "#{ft.label 'mealType_'+t, t.capitalize}"
        pills << "</div>"
      end
      pills << "</div>"
      pill = pills
    else
      pill = "#{ ft.hidden_field :mealType, value: @meal_type }"
    end
    pill.html_safe
  end

  def select_coursetypes(ft , attr = {})
    type = attr[:type]
    types = attr[:types]
    pills = ''
    if type.nil?
      pills << "<div class='radio-btns'>"
      types.map do |t|
        pills << "<div class='radio-item'>
                #{ft.radio_button :dishType, t, class: 'radio-btn btn--pill btn--pill--course'}"
        pills << "#{ft.label 'dishType_'+t.split(" ").join("_"), t.capitalize}"
        pills << "</div>"
      end
      pills << "</div>"
      pill = pills
    else
      pill = "#{ ft.hidden_field :dishType, value: @course_type }"
    end
    pill.html_safe
  end
end
