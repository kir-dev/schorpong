class TeamsController < ApplicationController
  before_action :require_admin, only: [:destroy]
  before_action :set_team, only: [:show, :edit, :update]

  def index
    @teams = Team.order(score: :desc).all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      Membership.create(team: @team, user: current_user, owner: true, active: true)
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :score)
    end
end
