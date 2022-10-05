class StatisticsController < ApplicationController 

  def index
    if params["date(1i)"] && params["date(2i)"] && params["date(3i)"]
      date_start = Date.civil(params["date(1i)"].to_i, params["date(2i)"].to_i,params["date(3i)"].to_i)
    else
      date_start = Time.now
    end
    params_m = [date_start.beginning_of_month, date_start.end_of_month]
    params_y = [date_start.beginning_of_year, date_start.end_of_year]
    @cars    = current_user.cars

    ### Monthly
    @total_repairs             = @cars.total_items(*params_m, items= :repairs)
    @total_chargings           = @cars.total_items(*params_m, items= :chargings)
    @total_taxes               = @cars.total_items(*params_m, items= :taxes)
    @all_car_repairs           = @cars.all_car_items(*params_m, items= :repairs)
    @all_car_chargings         = @cars.all_car_items(*params_m, items= :chargings)
    @all_car_taxes             = @cars.all_car_items(*params_m, items= :taxes)
    @total                     = @total_repairs.merge(@total_chargings, @total_taxes) { |_,a,b| a+b }  
    @max_length_repairs        = @total_repairs.values.max
    @max_length_chargings      = @total_chargings.values.max
    @max_length_taxes          = @total_taxes.values.max

    ### Yearly
    @total_repairs_year        = @cars.total_items_year(*params_y, items= :repairs)
    @total_chargings_year      = @cars.total_items_year(*params_y, items= :chargings)
    @total_taxes_year          = @cars.total_items_year(*params_y, items= :taxes)
    @all_car_repairs_year      = @cars.all_car_items_year(*params_y, items= :repairs)
    @all_car_chargings_year    = @cars.all_car_items_year(*params_y, items= :chargings)
    @all_car_taxes_year        = @cars.all_car_items_year(*params_y, items= :taxes)
    @total_year                = @total_repairs_year.merge(@total_chargings_year, @total_taxes_year) { |_,a,b| a+b }
    @max_length_repairs_year   = @total_repairs_year.values.max
    @max_length_chargings_year = @total_chargings_year.values.max
    @max_length_taxes_year     = @total_taxes_year.values.max

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end   
end
