class RepairsController < ApplicationController
  before_action :get_car
  before_action :authenticate_user!
  before_action :set_repair, only: %i[ update destroy ]  

  
  def create
    @repair = @car.repairs.build(repair_params.except(
      :id, :car_id, :utf8, :_method, :authenticity_token, :commit))
    
    respond_to do |format|
      begin        
        @repair.save
        format.html { redirect_to car_url(@car), notice: "Repair was successfully created." }
        format.json { render :plain => {success:true}.to_json, content_type: 'application/json' }
      rescue RangeError
        format.html { redirect_to car_url(@car), status: :unprocessable_entity, alert: "Something went wrong! Amount must be greather than 0. Allowed file types are jpg, png, gif ang pdf!" }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end
  
   
  def update
    respond_to do |format|
      begin 
        @repair.update(repair_params.except(:id, :car_id, :utf8, :_method, :authenticity_token, :commit))
        format.html { redirect_to car_url(@car), status: 303, notice: "Repair was successfully updated." }
        format.json { render :plain => {success:true}.to_json,status: 200, content_type: 'application/json' }
     
      rescue RangeError
        format.html { redirect_to car_url(@car), status: :unprocessable_entity, alert: "Something went wrong! Amount must be greather than 0. Allowed file types are jpg, png, gif ang pdf!"  }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repair.destroy

    respond_to do |format|
      format.html { redirect_to car_url(@car), status: 303, notice: "Repair was successfully destroyed." }
      format.json { render :plain => {success:true}.to_json, status: 200, content_type: 'application/json' }
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
          redirect_to (request.referrer || root_path)
        return
      end
    end
  

    # Only allow a list of trusted parameters through.
    def repair_params
      params.permit(:utf8, :_method, :authenticity_token, :commit, :description, :amount, :date, :content, :car_id, :id)
    end
  
  end
  