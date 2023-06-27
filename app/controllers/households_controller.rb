class HouseholdsController < ApplicationController
  before_action :set_household

  def show
    @users = @household.users

    @first_names = params.fetch(:name_first, [])
    @last_names = params.fetch(:name_last, [])
    @household_ids = params.fetch(:hosuehold_id, [])
  end


  private
  def set_household
    @household = Household.find(params[:id])
  end


end
