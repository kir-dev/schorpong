class TeamsController < ApplicationController
  before_action :require_admin, only: [:destroy]
  before_action :set_team, only: %i[show edit update]

  def index
    @page = Page.find_by(name: 'teams')
    @teams = Team.order(score: :desc).reject { |team| team.number_of_memberships.zero? }
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
      redirect_to @team, notice: 'Csapat sikeresen létrehozva.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Csapat sikeresen módosítva.'
    else
      render :edit
    end
  end

  def delete_memberships
    if current_user.admin?
      @team.delete_memberships!
      redirect_to teams_path, notice: 'Csapat sikeresen törölve.'
    else
      forbidden_page
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      if admin?
        params.require(:team).permit(:name, :score, :image, :remove_image)
      else
        params.require(:team).permit(:name, :image, :remove_image)
      end
    end
end
