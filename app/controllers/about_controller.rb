class AboutController < ApplicationController 

  # Overwrite car index method because of navbar logic to show all available cars
  def index
    @cars = current_user.cars.order(created_at: :asc)
  end
end
