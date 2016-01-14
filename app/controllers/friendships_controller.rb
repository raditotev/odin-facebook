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

  def destroy
    friendship = Friendship.find(params[:id])
    name = friendship.friend.name
    invitation = Invitation.find_by(from_user_id:friendship.user.id, to_user_id:friendship.friend.id) ||
                      Invitation.find_by(from_user_id:friendship.friend.id, to_user_id:friendship.user.id)
    invitation.update_attributes(approved:nil)
    friendship.destroy
    flash[:success] = "You're no longer friends with #{name}."
    redirect_to friends_user_path current_user
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

end
