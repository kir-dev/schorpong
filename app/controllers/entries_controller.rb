class EntriesController < ApplicationController

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    @event = Event.find(params[:event_id])
    @entry.event = @event
    if @entry.save
      redirect_to @event, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:team_id, :event_id, :comment)
    end
end
