class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      @post = like.post
      respond_to do |format|
        format.html {  redirect_to root_url }
        format.js
      end
    else
      #error message
      redirect_to root_url
    end
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    @post = like.post
    like.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
