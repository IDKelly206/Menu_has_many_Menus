class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]
  before_action :authenticate_user!, only: [:home]

  before_action :set_household, only: [:home]

  def home
    console
  end

  private

  def set_household
    @household = Household.find(current_user.household_id)
  end
end
