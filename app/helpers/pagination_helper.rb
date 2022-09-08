module PaginationHelper
  def total_pages
    @total_pages = (count_cars.to_f  / 3).ceil()
  end

  private 
  def count_cars
    @count = current_user.cars.count
  end    
end
