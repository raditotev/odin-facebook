class UsersController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts = current_user.posts
  end

  def profile
    @info = current_user.info
  end

  def friends
    # @friends = current_user.friends
  end
end
