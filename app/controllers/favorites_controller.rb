class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)

    if @favorite.save
      redirect_to @post, notice: 'Post has been favorited.'
    else
      redirect_to @post, alert: 'Failed to favorite the post.'
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(post_id: params[:post_id])
    @post = @favorite.post

    if @favorite.destroy
      redirect_to @post, notice: 'Post has been unfavorited.'
    else
      redirect_to @post, alert: 'Failed to unfavorite the post.'
    end
  end


  def index
    @favorites = current_user.favorites.includes(:post)
  end
end
