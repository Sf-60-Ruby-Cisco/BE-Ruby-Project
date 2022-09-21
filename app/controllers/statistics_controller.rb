class StatisticsController < ApplicationController 

  def index
    @cars = current_user.cars.order(created_at: :asc)    
    @total_repairs = Car.total_repairs
    @total_chargings = Car.total_chargings
    @total_taxes = Car.total_taxes
    @all_car_repairs = @cars.all_car_repairs
    @all_car_chargings = @cars.all_car_chargings
    @all_car_taxes = @cars.all_car_taxes

    @total = @total_repairs.merge(@total_chargings, @total_taxes) { |_,a,b| a+b }  
   
  end   
end
