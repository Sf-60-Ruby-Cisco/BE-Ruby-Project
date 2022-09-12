class StatisticsController < ApplicationController 

  def index
    @cars = current_user.cars.order(created_at: :asc)  

    @total_repairs = current_user.cars.joins(:repairs).group_by_month(:date, format: "%B %Y").sum(:amount_cents)  

    @all_cars = []
    for car in @cars
      if car.repairs.present?
        @all_cars.push(car.repairs.group_by_month(:date, format: "%B %Y").sum(:amount_cents))
      end
    end

    @license_plates = []
    for car in @cars
      if car.repairs.present?
        @license_plates.push(car.license_plate)
      end
    end
  end   
end