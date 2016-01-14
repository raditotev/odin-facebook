class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  def index
    @users = User.all
  end

  def show
    if Post.exists?(id: params[:id])
      @post = Post.find(params[:id])
    end
    @posts = @user.posts.includes(:author, :comments, :likes)
  end

  def profile
    @info = @user.info
  end

  def friends
    @invitations = @user.invitations.where(approved: false).includes(:from_user)
    @friendships = @user.friendships.order(id: :desc).includes(:friend)
  end

  def notifications

  end

  def set_user
    @user = User.find_by(username:params[:id])
  end
end
