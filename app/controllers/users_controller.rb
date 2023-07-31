class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_household

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save(validate: false) #skips validations
      respond_to do |format|
        format.html { redirect_to household_path(@household),
                      notice: "User was succesfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to household_path(@household), notice: "User was succesfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to household_path(@household),
                    notice: "User was succesfully destroyed." }
      format.turbo_stream
    end
  end




  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name_first, :name_last, :household_id, :email)
  end

  def set_household
    @household = current_user.household_id
  end
end
