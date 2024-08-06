module FilterHelper

  #  Pre-filtered selection for search
  def filter_types(attr = {})
    unless attr[:type].nil?
      type = attr[:type]
      type = type.capitalize
      pills = "<li class='btn--pill btn--pill--meal'>#{type}</li>"
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

  def filter_dietary(attr = {})
    unless attr[:dietary].nil?
      dietary = attr[:dietary]
      pills = dietary.map { |dr| "<li class='btn--pill btn--pill--dietary'>#{dr.capitalize}</li>" }
      pill = pills.join(' ')
      pill.html_safe
    end
  end

  # def dietary_filters(ft, attr = {})
  #   unless attr[:dietary].nil?
  #     dietary = attr[:dietary]
  #     pills = ''
  #     dietary.each { |dr| pills << "#{ ft.hidden_field :health, value: dr }" }
  #     pill = pills
  #   end
  #   pill.html_safe
  # end

  # Filtering selection for search

  def select_filter_course_types(attr = {})
    unless attr[:course_types].nil?
    course_types = attr[:course_types]
    course_type = attr[:course_type].nil? ? nil : attr[:course_type]

    pills = course_types.map { |ct|
        "<div class='radio-item'>
        <input class='radio-btn btn--pill btn--pill--course' type='radio'
               name='dishType'
               value='#{ct}'
              data-radio-selection-target='radioInput'
              data-course-new-form-target='courseRadioInput'
               >
        <label for='#{ct}'
              data-action='click->radio-selection#selectRadioOption
                           click->course-new-form#assignCourseType
                           click->recipe-search-filter#assignCourseFilter'
               >
               #{ct.capitalize} </label>
        </div>"
      }
      pill = pills.join(' ')
      pill.html_safe
    end
  end

  def select_filter_meal_types(attr = {})
    unless attr[:meal_types].nil?

      meal_types = attr[:meal_types]

      pills = meal_types.map { |mt|
        "<div class='radio-item'>
        <input class='radio-btn btn--pill btn--pill--meal' type='radio'
              name='mealType'
              value='#{mt}'
              data-radio-selection-target='radioInput'
              >
        <label for='#{mt}'
              data-action='click->radio-selection#selectRadioOption
              click->recipe-search-filter#assignMealFilter'
              >
              #{mt.capitalize} </label>
        </div>"
      }
      pill = pills.join(' ')
      pill.html_safe
    end
  end

  # def select_coursetypes(ft , attr = {})
  #   type = attr[:type]
  #   types = attr[:types]
  #   pills = ''
  #   if type.nil?
  #     pills << "<div class='radio-btns'>"
  #     types.map do |t|
  #       pills << "<div class='radio-item'>
  #               #{ft.radio_button :dishType, t, class: 'radio-btn btn--pill btn--pill--course', checked: t == types.first }"
  #       pills << "#{ft.label 'dishType_'+t.split(" ").join("_"), t.capitalize}"
  #       pills << "</div>"
  #     end
  #     pills << "</div>"
  #     pill = pills
  #   else
  #     pill = "#{ ft.hidden_field :dishType, value: @course_type }"
  #   end
  #   pill.html_safe
  # end

  # def select_mealtypes(ft , attr = {})
  #   type = attr[:type]
  #   types = attr[:types]
  #   pills = ''
  #   if type.nil?
  #     pills << "<div class='radio-btns'>"
  #     types.map do |t|
  #       pills << "<div class='radio-item'>
  #               #{ft.radio_button :mealType, t, class: 'radio-btn btn--pill btn--pill--meal', checked: t == types.first }"
  #       pills << "#{ft.label 'mealType_'+t, t.capitalize}"
  #       pills << "</div>"
  #     end
  #     pills << "</div>"
  #     pill = pills
  #   else
  #     pill = "#{ ft.hidden_field :mealType, value: @meal_type }"
  #   end
  #   pill.html_safe
  # end
end
