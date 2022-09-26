class ChargingsController < ApplicationController
  include ChargingsControllerConcern

  before_action :get_car
  before_action :authenticate_user!
  before_action :set_charging, only: %i[ edit update destroy ]

  # GET /cars/:car_id/chargings/:id/edit
  def edit
  end

  # POST /cars/:car_id/chargings
  def create
    @charging = @car.chargings.new(charging_params)
    respond_to do |format|
      if @charging.save
        # Send params &update=chargings to views/cars/show.turbo_stream
        # to update the Chargings Table and its Pagination (request is processed as Turbo_Stream)
        format.html { 
          redirect_to car_url(@car, params: { update: "chargings", clear: "form" }), 
          status: :see_other, 
          notice: "Charging was successfully created."
        }
        format.json { render :plain => {success:true}.to_json, status: :created, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @charging, 
              form_for= :charging,
              form= "chargings/form", 
              error_message= "There was an error when creating a charging, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @charging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/:car_id/chargings/:id
  def update
    respond_to do |format|
      if @charging.update(charging_params)
        format.turbo_stream  # views/chargings -> update.turbo_stream.slim
        format.html { redirect_to car_url(@car), status: :see_other, notice: "Charging was successfully updated." }
        format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
      else
        # Replace the current Edit Form with new Edit Form with errors
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @charging, 
              form_for= :charging,
              form= "chargings/form", 
              error_message= "There was an error when updating a charging, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @charging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/:car_id/chargings/:id
  def destroy
    @charging.destroy

    respond_to do |format|
      format.html { 
        redirect_to car_url(@car, params: { update: "chargings" }), 
        status: :see_other, 
        notice: "Charging was successfully destroyed." 
      }
      format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charging
      @charging = @car.chargings.find(params[:id])
    end

    def get_car
      @car = current_user.cars.find(params[:car_id])
    end

    # Only allow a list of trusted parameters through.
    def charging_params
      params.require(:charging).permit(:brand_station, :amount, :date)
    end

end
