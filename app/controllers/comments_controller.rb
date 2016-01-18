class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      author = @comment.post.author
      notification = Notification.create!(user: author)
      @comment.update_attributes(notification: notification)
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      flash[:success] = "Comment has been changed!"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to root_url
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.notification.destroy
    comment.destroy
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end
end
