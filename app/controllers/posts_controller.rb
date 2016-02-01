class PostsController < ApplicationController
  def index
    @posts = []
    friends = current_user.friends.includes(:comments, :likes)
    friends.each do |friend|
      friend.posts.includes(:author, :comments, :likes).each { |post| @posts << post }
    end
    current_user.posts.includes(:author, :comments, :likes).each { |post| @posts << post }
    @posts.sort_by! {|post| -post.created_at.strftime("%s").to_i }
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash.now[:success] = "Post created!"
      respond_to do |format|
        format.html {redirect_to current_user}
        format.js
      end
    else
      flash[:error] = "There was a problem...Post hasn't been created!"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      respond_to do |format|
        format.html { redirect_to current_user }
        format.js
      end
    else
      flash[:error] = "Post wasn't updated!"
      redirect_to current_user
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
