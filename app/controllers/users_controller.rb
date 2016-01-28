class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    not_listed_users = [current_user]
    current_user.friends.each { |friend| not_listed_users << friend }
    current_user.invites.each { |invite| not_listed_users << invite }
    current_user.invitations.each { |invitation| not_listed_users << invitation }
    all_users = User.all
    @users = []
    all_users.each do |user|
      unless not_listed_users.include? user
        @users << user
      end
    end
    @users
  end

  def show
    if Post.exists?(id: params[:id])
      @post = Post.find(params[:id])
    end
    @posts = @user.posts.order(id: :desc).includes(:author, :comments, :likes)
  end

  def profile
    @info = @user.info
  end

  def friends
    @invitations = @user.received_invitations.where(approved: false).includes(:from_user)
    @friends = @user.friends.order(username: :asc)
  end

  def notifications
    @notifications = current_user.notifications.order(id: :desc)
  end

  def set_user
    @user = User.find_by(username:params[:id])
  end
end
