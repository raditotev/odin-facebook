class InfosController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

def new
  @info = Info.new
end

  def edit
    @info = Info.find(params[:id])
  end

  def create
    info = Info.new(info_params)
    if info.save
      flash[:success] = "Profile updated"
      redirect_to profile_user_path(current_user)
    else
      flash[:error] = "Profile hasn't been updated. Please try again."
      redirect_to profile_user_path(current_user)
    end
  end

  def update
    info = Info.find(params[:id])
    if info.update_attributes(info_params)
      flash[:success] = "Profile updated"
      redirect_to profile_user_path(current_user)
    else
      flash[:error] = "Profile hasn't been updated. Please try again."
      redirect_to profile_user_path(current_user)
    end
  end

  private

  def info_params
    params.require(:info).permit(:user_id,
                                                :birthday,
                                                :work,
                                                :education,
                                                :address,
                                                :phone,
                                                :about)
  end

  def correct_user
    @user = Info.find(params[:id]).user
     flash.now[:error] = "You are not authorized" unless @user == current_user
  end

end
