class StatisticsController < ApplicationController 

  def index
    @cars = current_user.cars.order(created_at: :asc)      
    @total_repairs = Car.total_repairs    
    @total_chargings = Car.total_chargings
    @all_car_repairs = Car.all_car_repairs
    @all_car_chargings = Car.all_car_chargings

    @total = @total_repairs.merge(@total_chargings) { |_,a,b| a+b }  
   
  end   
end
