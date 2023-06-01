class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :name_first, :name_last, presence: true

  belongs_to :household

  before_validation :assign_household

  def assign_household
    if self.household_id.nil?
      Household.create
      self.household_id = Household.last.id
    end
  end



end
