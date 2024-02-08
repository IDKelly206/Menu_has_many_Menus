class Meal::Multicourse
  def self.create(course_params)
    new(course_params).create(course_params)
  end


  def initialize(course_params)
    @meals = course_params[:meal_ids].first.split.map { |id| Meal.find(id.to_i) }
    #  course_type needs to be predetermined on Meal page
    @course_type = course_params[:course_type]
    @erecipe_id = course_params[:erecipe_id]
  end

  def create(course_params)
    validate_params!

    @course_count = @meals.count
    @new_courses = 0
    @courses = []

    @meals.each do |meal|
      @courses.push(Course.create!(course_type: @course_type, erecipe_id: @erecipe_id, meal_id: meal.id))
      @new_courses += 1
    end

    @courses
  end


  def validate_params!
    raise "Invalid params" unless @meals.present?
    raise "Invalid params" unless @course_type.present?
    raise "Invalid params" unless @erecipe_id.present?
  end
end
