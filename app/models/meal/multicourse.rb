class Meal::Multicourse
  def self.create(course_params)
    new(course_params).create(course_params)
  end


  def initialize(course_params)
    @meal_ids = course_params[:meal_ids].first.split.map { |id| id.to_i }
    @course_type = course_params[:course_type]
    @erecipe_id = course_params[:erecipe_id]
  end

  def create(course_params)
    validate_params!

    @course_count = @meal_ids.count
    @new_courses = 0

    @meal_ids.each do |meal_id|
      Course.create!(course_type: @course_type, erecipe_id: @erecipe_id, meal_id: meal_id,)
      @new_courses += 1
    end
  end


  def validate_params!
    raise "Invalid params" unless @meal_ids.present?
    raise "Invalid params" unless @course_type.present?
    raise "Invalid params" unless @erecipe_id.present?
  end
end
