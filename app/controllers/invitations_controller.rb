class InvitationsController < ApplicationController

  def create
    invitation = Invitation.new(invitation_params)
    if invitation.save
      flash[:success] = "Invitation sent!"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong. Try again."
      redirect_to users_path
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:from_user_id, :to_user_id)
  end

end
