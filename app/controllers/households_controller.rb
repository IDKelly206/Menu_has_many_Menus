class HouseholdsController < ApplicationController
  before_action :set_household

  def show
    @users = @household.users
  end


  private
  def set_household
    @household = Household.find(params[:id])
  end

end
