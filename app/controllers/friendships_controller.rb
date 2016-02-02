class FriendshipsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def destroy
    friendship = Friendship.find_by(user: current_user.id, friend: params[:id])
    name = friendship.friend.name
    invitation = Invitation.find_by(from_user_id:current_user.id, to_user_id:params[:id]) ||
                      Invitation.find_by(from_user_id:params[:id], to_user_id:current_user.id)
    invitation.update_attributes(approved:nil)
    friendship.destroy
    flash[:success] = "You're no longer friends with #{name}."
    redirect_to friends_user_path current_user
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end

  def correct_user
    user = Friendship.find_by(user: current_user, friend: params[:id]).user
    flash.now[:error] = "You are not authorized" unless user == current_user
  end

end
