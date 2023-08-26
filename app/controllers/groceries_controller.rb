class GroceriesController < ApplicationController
  before_action :set_household

  def index
    # show all gList item(s)
    @groceries = Grocery.all.where('household_id = ?', @household).all

    console
  end

  def new
    # create gList item(s)
    @grocery = Grocery.new

    console
  end

  def create
  end

  def show
    # show specific gList item
  end

  def edit
    # update specific gList item
  end

  def update
  end

  def destroy
    # remove specific gList itme
  end


  private

  def set_household
    @household = current_user.household_id
  end
end
