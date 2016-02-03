class CommentsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    else
      redirect_to root_url
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash.now[:success] = "Comment has been edited!"
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to root_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content, :user_id)
  end

  def correct_user
    user = Comment.find(params[:id]).user
    unless user == current_user
      flash[:danger] = "You are not authorized"
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js {render text: "alert('You are not authorized!')"}
      end
    end
  end
end
