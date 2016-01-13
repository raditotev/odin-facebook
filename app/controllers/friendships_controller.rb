class FriendshipsController < ApplicationController

  def create
    friendship = Friendship.new(friendship_params)
    invitation = Invitation.find(params[:invitation])
    if friendship.save
      flash[:success] = "You are now friends with #{friendship.friend.name}"
      redirect_to friends_user_path current_user
      invitation.update_attributes(approved: true)
    else
      flash[:error] = "Something went wrong. Try again."
      redirect_to friends_user_path current_user
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

end
