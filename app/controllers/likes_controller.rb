class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      user = Post.find(like.post.id).author
      notification = Notification.create!(user: user)
      like.update_attributes(notification: notification)
      #success message
      redirect_to root_url
    else
      #error message
      redirect_to root_url
    end
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    like.notification.destroy
    like.destroy
    redirect_to root_url
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
