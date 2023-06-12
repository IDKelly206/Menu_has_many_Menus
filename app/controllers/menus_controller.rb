class MenusController < ApplicationController
  before_action :set_household
  before_action :set_menu, only: [:show]

  def index
    @menus = Menu.all.where(household_id: @household)
    @meal_type = %w(Breakfast Lunch Dinner)
  end

  def show

  end

  def new
    @menu = Menu.new
  end

  def create
  end

  private
  def set_household
    @household = current_user.household_id
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:date)
  end
end
