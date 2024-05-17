class PlannerForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_accessor :meal_type, :user_ids, :menu_ids

  validates :meal_type, presence: { message: "Must select Meal type" }
  validates :menu_ids, presence: { message: "A date needs to be choosen" }
  validates :user_ids, presence: { message: "Choose a diner for this meal" }


  def submit
    return false if invalid?

    true
  end
end
