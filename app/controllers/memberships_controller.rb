class MembershipsController < ApplicationController
  before_action :require_login
  before_action :set_membership, only: [:approve, :destroy]

  def create
    @team = Team.find(params[:team_id])
    if @team.user_can_join?(current_user)
      @team.join!(current_user)
      return redirect_back(fallback_location: team_path(@team))
    else
      forbidden_page
    end
  end

  def approve
    @membership.approve!
    redirect_to @membership, notice: 'Membership was successfully updated.'
  end

  def destroy
    @membership.destroy
    redirect_to memberships_url, notice: 'Membership was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:owner, :active, :user_id, :team_id)
    end
end
