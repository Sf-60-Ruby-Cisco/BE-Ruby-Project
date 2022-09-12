module NavbarHelper
  # showing navbar button with all available cars
  def user_cars
    @cars = current_user.cars.order(created_at: :asc)
  end
end
