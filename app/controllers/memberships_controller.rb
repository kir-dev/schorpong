class MembershipsController < ApplicationController
  before_action :require_login

  def create
    @team = Team.find(params[:team_id])
    if @team.user_can_join?(current_user)
      @team.join!(current_user)
      redirect_back(fallback_location: team_path(@team))
    else
      forbidden_page
    end
  end

  def approve
    @membership = Membership.find(params[:membership_id])
    if current_user.admin_of?(@membership.team)
      @membership.approve!
      redirect_to @membership.team, notice: 'Membership was successfully updated.'
    else
      forbidden_page
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to memberships_url, notice: 'Membership was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:owner, :active, :user_id, :team_id)
    end
end
