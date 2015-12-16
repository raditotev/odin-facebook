class PostsController < ApplicationController
  def index
    @users = User.all
    @posts = []
    friends = current_user.friends.includes(:comments, :likes)
    friends.each do |friend|
      friend.posts.each { |post| @posts << {post: post,
                                                                comments: post.comments,
                                                                likes: post.likes,
                                                                } }
    end
    @posts.sort_by! {|post| -post[:post].created_at.strftime("%s").to_i }
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      flash[:success] = "Post created!"
      redirect_to current_user
    else
      flash[:error] = "There was a problem...Post hasn't been created!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
