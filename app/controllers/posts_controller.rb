class PostsController < ApplicationController
  def index
    @users = User.all
    @posts = []
    friends = current_user.friends
    friends.each do |friend|
      friend.posts.each { |post| @posts << post }
    end
    @posts.sort_by! {|post| -post.created_at.strftime("%s").to_i }
  end
end
