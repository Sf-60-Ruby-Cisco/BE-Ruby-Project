class AdminController < ApplicationController

  def index
    @users = User.where.not(username: current_user.username).order(created_at: :asc).page(params[:page])
    @users = User.where.not(username: current_user.username).page(@users.total_pages) if @users.to_a.empty? 
  end

end
