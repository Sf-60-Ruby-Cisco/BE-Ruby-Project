class ChargingsController < ApplicationController
  before_action :get_car
  before_action :authenticate_user!
  before_action :set_charging, only: %i[ update destroy ]

  # POST /cars/:car_id/chargings
  def create
    @charging = Charging.new(charging_params.except(
            :id, :car_id, :utf8, :_method, :authenticity_token, :commit).merge(car_id: @car.id))

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

  # PATCH/PUT /cars/:car_id/chargings
  def update
    respond_to do |format|
      if @charging.update(charging_params.except(:id, :car_id, :utf8, :_method, :authenticity_token, :commit))
        format.html { redirect_to car_url(@car), status: 303, notice: "Charging was successfully updated." }
        format.json { render :plain => {success:true}.to_json, status: 200, content_type: 'application/json' }
      else
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
      params.permit(:utf8, :_method, :authenticity_token, :commit, :brand_station, :amount, :date, :car_id, :id)
    end

end
