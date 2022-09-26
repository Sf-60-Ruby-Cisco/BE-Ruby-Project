class TaxesController < ApplicationController
  include ChargingsControllerConcern
  
  before_action :get_car
  before_action :authenticate_user!
  before_action :set_tax, only: %i[ edit update destroy ]

  # GET /cars/:car_id/taxes/:id/edit
  def edit
  end

  # POST /cars/:car_id/taxes
  def create
    @tax = @car.taxes.new(tax_params)
    respond_to do |format|
      if @tax.save
        format.html { 
          redirect_to car_url(@car, params: { update: "taxes", clear: "form" }), 
          status: :see_other, 
          notice: "Tax was successfully added."
        }
        format.json { render :plain => {success:true}.to_json, status: :created, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @tax, 
              form_for= :tax,
              form= "taxes/form", 
              error_message= "There was an error when adding a tax, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @charging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/:car_id/taxes/:id
  def update
    respond_to do |format|
      if @tax.update(tax_params)
        format.turbo_stream  # views/taxes -> update.turbo_stream.slim
        format.html { redirect_to car_url(@car), status: :see_other, notice: "Tax was successfully updated." }
        format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @tax, 
              form_for= :tax,
              form= "taxes/form", 
              error_message= "There was an error when updating a tax, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @charging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/:car_id/taxes/:id
  def destroy
    @tax.destroy

    respond_to do |format|
      format.html { 
        redirect_to car_url(@car, params: { update: "taxes" }), 
        status: :see_other, 
        notice: "Tax was successfully destroyed." 
      }
      format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax
      @tax = @car.taxes.find(params[:id])
    end

    def get_car
      @car = current_user.cars.find(params[:car_id])
    end

    # Only allow a list of trusted parameters through.
    def tax_params
      params.require(:tax).permit(:tax_type, :description, :amount, :date)
    end
end
