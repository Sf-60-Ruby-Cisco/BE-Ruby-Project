class AboutController < ApplicationController 

  # Overwrite car index method because of navbar logic to show all available cars
  def index
    @cars = Car.where(user: current_user).all.order("created_at ASC")
  end
end
