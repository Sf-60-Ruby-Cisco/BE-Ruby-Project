class CarsController < ApplicationController  
  load_and_authorize_resource
  before_action :set_car, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # before_action :check_user, :only => [:edit, :show]
  
  # GET /cars or /cars.json
  def index   
    @cars = current_user.cars.includes(:content_attachment).order(created_at: :asc).page(params[:page])
    # Prevent pagination to show empty page 
    @cars = current_user.cars.includes(:content_attachment).page(@cars.total_pages) if @cars.to_a.empty?    
  end

  # GET /cars/1 or /cars/1.json
  def show
    @chargings = @car.chargings.order(created_at: :desc).page(params[:chargings_page])
    @repairs = @car.repairs.includes(:content_attachment).order(created_at: :desc).page(params[:repairs_page])
    @taxes = @car.taxes.order(created_at: :desc).page(params[:taxes_page])
    @expenses = @car.expenses.order(created_at: :desc).page(params[:expenses_page])
    respond_to do |format|
      format.html
      format.turbo_stream # views/cars/ -> show.turbo_stream.slim
    end
  end
 
 
  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit; end

  # POST /cars or /cars.json
  def create       
    @car = current_user.cars.new(car_params)     
    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), status: :created, notice: t("alerts.success") }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: t("alerts.sup")}
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: t("alerts.destroy") }
      format.json { head :no_content }
    end
  end

  def purge_content
    @car = Car.find(params[:id])    
    @car.content.purge
    redirect_to cars_url, notice: t("alerts.delpic") 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])       
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:brand, :model, :engine, :fuel_type, :year, :license_plate, :content)
    end

    # Deny url to be edited, and deny access to other users cars
    # def check_user
    #   @car = current_user.cars.find(params[:id])
    # end
end
