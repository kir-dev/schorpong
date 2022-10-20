class RentsController < ApplicationController
  before_action :require_admin, only: %i[ index approve reject take return ]
  before_action :require_login, only: %i[ new create users_index ]
  before_action :set_rent, only: %i[ show edit update destroy ]

  # GET /rents or /rents.json
  def index
    states = Rent.states.keys
    states.each {|state| params[state.to_sym] ="1"} unless params.keys.any?{|param| states.include?(param)}
    @rents = Rent.filter(rent_filter_params)
  end

  # GET /rents/1 or /rents/1.json
  def show
  end

  # GET /rents/new
  def new
    return redirect_to root_path if params[:item_id].nil?
    @rent = Rent.new
    @rent.item_id = params[:item_id]
  end

  # GET /rents/1/edit
  def edit
  end

  # POST /rents or /rents.json
  def create
    @rent = Rent.new(rent_params)

    respond_to do |format|
      if @rent.save
        RentMailer.with(rent: @rent).create_email.deliver_later
        format.html { redirect_to users_rents_url, notice: "Sikeres kölcsönzés." }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rents/1 or /rents/1.json
  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to rent_url(@rent), notice: "Rent was successfully updated." }
        format.json { render :show, status: :ok, location: @rent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rents/1 or /rents/1.json
  def destroy
    @rent.destroy

    respond_to do |format|
      format.html { redirect_to rents_url, notice: "Rent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve
    rent = Rent.find(params[:rent])
    rent.approve!
    return redirect_to rents_path
  end

  def reject
    rent = Rent.find(params[:rent])
    rent.reject!
    return redirect_to rents_path
  end

  def take
    rent = Rent.find(params[:rent])
    rent.take!
    return redirect_to rents_path
  end

  def return
    rent = Rent.find(params[:rent])
    rent.return!
    return redirect_to rents_path
  end

  def users_index
    states = Rent.states.keys
    states.each {|state| params[state.to_sym] ="1"} unless params.keys.any?{|param| states.include?(param)}
    @rents = Rent.users_filter(rent_filter_params, current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rent
      @rent = Rent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.require(:rent).permit(:item_id, :user_id, :begin, :end, :state)
    end

  def rent_filter_params
    params.permit(:unprocessed, :approved, :rejected, :taken, :returned)
  end
end
