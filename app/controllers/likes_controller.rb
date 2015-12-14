class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      #success message
      redirect_to root_url
    else
      #error message
      redirect_to root_url
    end
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    like.destroy
    redirect_to root_url
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
