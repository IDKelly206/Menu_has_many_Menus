class PlannerForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attr_accessor :meal_type, :user_ids, :menu_ids

  validates :user_ids, :menu_ids, :meal_type, presence: true


  def submit
    return false if invalid?

    true
  end
end
