class UsersController < ApplicationController
  before_action :require_admin, except: %i[show edit update]

  before_action :set_user, only: %i[show edit update]
  before_action :require_same_or_admin_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @user.image.purge if user_params[:remove_image] == "1"
    if @user.update(user_params.except(:remove_image))
      redirect_to(@user, notice: "User was successfully updated.")
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    permitted_attributes = %i[image remove_image]
    permitted_attributes.push(:admin) if admin?
    params.require(:user).permit(permitted_attributes)
  end

  def require_same_or_admin_user
      redirect_to root_url unless can_update_user?(@user)
  end
end
