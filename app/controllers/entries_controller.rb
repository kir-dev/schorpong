class EntriesController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:toggle_showed_up]

  def create
    @entry = Entry.new(entry_params)
    @event = Event.find(params[:event_id])
    @entry.event = @event
    if @entry.save
      redirect_to @event, notice: 'Sikeresen neveztél az eseményre.'
    else
      render :new
    end
  end

  def toggle_showed_up
    @entry = Entry.find(params[:entry_id])
    @entry.toggle_showed_up!
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to @entry.team, notice: 'Entry was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:team_id, :event_id, :comment, :entry_id)
    end
end
