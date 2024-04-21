require 'rails_helper'

RSpec.describe Course, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "#new_course" do
    # date = Date.new(2001, 1, 1)
    # menu = Menu.create(date:, household_id: 1)
    # meal_type = Meal::MEAL_TYPES.sample
    # meal = Meal.create(menu:, meal_type:, user_id: 1)
    # meal = Meal.last
    # course_type = Course::COURSE_TYPES.sample
    # erecipe_id = "recipeID"
    # course_params = { erecipe_id:, course_type:, meal_ids: [meal.id.to_s] }

    # course = Meal::Multicourse.new(course_params)

    it "creates a new Course instance" do
      expect(course).to be_an_instance_of Course
    end

    it "saves the Course to the database" do

    end
  end
end
