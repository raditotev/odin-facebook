class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end
end
