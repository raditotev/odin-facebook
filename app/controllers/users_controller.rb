class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if Post.exists?(id: params[:id])
      @post = Post.find(params[:id])
    end
    @posts = current_user.posts.includes(:author, :comments, :likes)
  end

  def profile
    @info = current_user.info
  end

  def friends
    @invitations = current_user.invitations.where(approved: false).includes(:from_user)
    @friendships = current_user.friendships.order(id: :desc).includes(:friend)
  end

  def notifications

  end
end
