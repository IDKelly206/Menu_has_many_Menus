class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  belongs_to :household

  before_validation :assign_household

  def assign_household
    Household.create
    self.household_id = Household.last.id
    user = self
    user.household.name = " #{user.name_last.capitalize} + household"
  end

end
