class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save(validate: false)
      redirect_back_or_to household_path(current_user.household_id)

    else
      render :new, status: :unprocessable_entity
    end
  end



  private
  def user_params
    params.require(:user).permit(:name_first, :name_last, :household_id, :email)
  end

  def set_household
    @household = current_user.household_id
  end

end
