class StatisticsController < ApplicationController 

  def index
    @cars = current_user.cars.order(created_at: :asc)  
    @total_repairs = current_user.cars.joins(:repairs).group_by_month(:date, format: "%B %Y").sum(:amount_cents)
  
  end   
end