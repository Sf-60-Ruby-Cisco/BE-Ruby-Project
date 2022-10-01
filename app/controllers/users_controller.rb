class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: %i[ update destroy ]


  def destroy    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to (request.referrer||admin_path),status: 302, notice: 'User was successfully deleted.' }   
      format.json { head :no_content } 
    end
  end

  def update
    @user.update_column(:email, params[:user].delete(:email))
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to (request.referrer||admin_path),status: 302, notice: "User successfully updated"}
        format.json { render :show, status: 302, location: @user }
      else
        format.html { redirect_to (request.referrer||admin_path), status: :unprocessable_entity, alert: "Something is missing" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
  def set_user
    @user = User.find(params[:id])     
  end

  def user_params
    params.require(:user).permit(:username, :email, :admin)
  end
end
