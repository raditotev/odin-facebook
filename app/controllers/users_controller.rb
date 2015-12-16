class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if Post.exists?(id: params[:id])
      @post = Post.find(params[:id])
    end
    @posts = current_user.posts
  end

  def profile
    @info = current_user.info
  end

  def friends
    # @friends = current_user.friends
  end

  def notifications

  end
end
