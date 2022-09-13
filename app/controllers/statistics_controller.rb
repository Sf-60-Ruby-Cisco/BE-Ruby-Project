class StatisticsController < ApplicationController 

  def index
    @cars = current_user.cars.order(created_at: :asc)  

    @total_repairs = current_user.cars.joins(:repairs).group_by_month(:date, format: "%B %Y").sum(:amount_cents)  

    @total_chargings = current_user.cars.joins(:chargings).group_by_month(:date, format: "%B %Y").sum(:amount_cents)  

    @total = @total_repairs.merge(@total_chargings) { |_,a,b| a+b }

    @all_car_repairs = []
    @all_car_chargings = []
    for car in @cars
      if car.repairs.present?
        @all_car_repairs.push(car.repairs.group_by_month(:date, format: "%B %Y").sum(:amount_cents))
      end
      if car.chargings.present?
        @all_car_chargings.push(car.chargings.group_by_month(:date, format: "%B %Y").sum(:amount_cents))
      end
    end

    @license_plate_repairs = []
    @license_plate_chargings = []
    for car in @cars
      if car.repairs.present?
        @license_plate_repairs.push(car.license_plate)
      end
      if car.chargings.present?
        @license_plate_chargings.push(car.license_plate)
      end    
    end
  end   
end
