class ExpensesController < ApplicationController
  include ChargingsControllerConcern

  before_action :get_car
  before_action :authenticate_user!
  before_action :set_expense, only: %i[ edit update destroy ]

  # GET /cars/:car_id/expenses/:id/edit
  def edit; end

  # POST /cars/:car_id/expenses
  def create
    @expense = @car.expenses.new(expense_params)
    respond_to do |format|
      if @expense.save
        # Send params &update=expenses to views/cars/show.turbo_stream
        # to update the Expenses Table and its Pagination (request is processed as Turbo_Stream)
        format.html { 
          redirect_to car_url(@car, params: { update: "expenses", clear: "form" }), 
          status: :see_other, 
          notice: "Expense was successfully created."
        }
        format.json { render :plain => {success:true}.to_json, status: :created, content_type: 'application/json' }
      else
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @expense, 
              form_for= :expense,
              form= "expenses/form", 
              error_message= "There was an error when creating a expense, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/:car_id/expenses/:id
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.turbo_stream  # views/expenses -> update.turbo_stream.slim
        format.html { redirect_to car_url(@car), status: :see_other, notice: "Expense was successfully updated." }
        format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
      else
        # Replace the current Edit Form with new Edit Form with errors
        format.turbo_stream do
          render turbo_stream: 
            stream_form_errors_and_error_message(
              record= @expense, 
              form_for= :expense,
              form= "expenses/form", 
              error_message= "There was an error when updating a expense, please try again."
            )
        end
        format.html { redirect_to car_url(@car), status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/:car_id/expenses/:id
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { 
        redirect_to car_url(@car, params: { update: "expenses" }), 
        status: :see_other, 
        notice: "Expense was successfully destroyed." 
      }
      format.json { render :plain => {success:true}.to_json, status: :ok, content_type: 'application/json' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = @car.expenses.find(params[:id])
    end

    def get_car
      @car = current_user.cars.find(params[:car_id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:description, :amount, :date)
    end

end