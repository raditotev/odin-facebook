class InvitationsController < ApplicationController

  def create
    invitation = Invitation.new(invitation_params)
    if invitation.save
      recipient = invitation.to_user
      notification = Notification.create!(user: recipient)
      invitation.update_attributes(notification: notification)
      flash[:success] = "Invitation sent!"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong. Try again."
      redirect_to users_path
    end
  end

  def update
    invitation = Invitation.find(params[:id])
    if invitation_params[:approved]
      invitation.update_attributes(invitation_params)
      flash[:success] = "Request has been approved."
      redirect_to friends_user_path current_user
    elsif invitation_params[:approved] == nil
      invitation.update_attributes(invitation_params)
      flash[:success] = "Request has been denied."
      redirect_to friends_user_path current_user
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:from_user_id, :to_user_id, :approved)
  end

end
