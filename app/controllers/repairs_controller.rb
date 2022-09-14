class RepairsController < ApplicationController
  include ChargingsControllerConcern

  before_action :get_car
  before_action :authenticate_user!
  before_action :set_repair, only: %i[edit update destroy ]  

  def edit; end

  def create
    @repair = @car.repairs.new(repair_params)
    
    respond_to do |format|             
      if @repair.save
        format.html { 
          redirect_to car_url(@car, params: { created_repair: true }), 
          status: :see_other, 
          notice: "Repair was successfully created." 
        }
        format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @repair, 
              form_for= :repair,
              form= "repairs/form", 
              error_message= "There was an error when creating a repair, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity, alert: "Something went wrong! Amount must be greather than 0. Allowed file types are jpg, png, gif ang pdf!" }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @repair.update(repair_params) 
        format.turbo_stream # views/repairs -> update.turbo_stream.slim
        format.html { redirect_to car_url(@car), status: :see_other, notice: "Repair was successfully updated." }
        format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream:
            stream_form_errors_and_error_message(
              record= @repair, 
              form_for= :repair,
              form= "repairs/form", 
              error_message= "There was an error when updating a repair, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repair.destroy

    respond_to do |format|
      format.html { 
        redirect_to car_url(@car, params: { deleted_repair: true }), 
        status: :see_other, 
        notice: "Repair was successfully destroyed." 
      }
      format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair
      @repair = @car.repairs.find(params[:id])
    end

    def get_car
      @car = Car.find(params[:car_id])
        unless current_user.id == @car.user_id
          redirect_to (request.referrer||root_path)
        return
      end
    end
  
    # Only allow a list of trusted parameters through.
    def repair_params
      params.require(:repair).permit(:description, :amount, :date, :content)
    end
  
  end
  