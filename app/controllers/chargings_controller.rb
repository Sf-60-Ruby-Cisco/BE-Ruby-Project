class ChargingsController < ApplicationController
  before_action :get_car
  before_action :authenticate_user!
  before_action :set_charging, only: %i[ edit update destroy ]

  # GET /cars/:car_id/chargings/:id
  def edit
  end

  # POST /cars/:car_id/chargings
  def create
    @charging = @car.chargings.new(charging_params)

    respond_to do |format|
      if @charging.save
        format.html { redirect_to car_url(@car), notice: "Charging was successfully created." }
        format.json { render :plain => {success:true}.to_json, status: 200, content_type: 'application/json' }
      else
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
        format.json { render :plain => {success:true}.to_json, status: 200, content_type: 'application/json' }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@charging)}_form", partial: "form", locals: { car: @car, charging: @charging }) 
        }
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @charging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/:car_id/chargings/:id
  def destroy
    @charging.destroy

    respond_to do |format|
      format.html { redirect_to car_url(@car), status: 303, notice: "Charging was successfully destroyed." }
      format.json { render :plain => {success:true}.to_json, status: 200, content_type: 'application/json' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charging
      @charging = @car.chargings.find(params[:id])
    end

    def get_car
        @car = Car.find(params[:car_id])
        if current_user != @car.user
            redirect_to root_path, alert: "Access Denied!"
        end
        return
    end

    # Only allow a list of trusted parameters through.
    def charging_params
      params.require(:charging).permit(:brand_station, :amount, :date)
    end

end
