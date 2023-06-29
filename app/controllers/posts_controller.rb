class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        PostMailer.post_mail(@post).deliver 
        redirect_to posts_path, notice: "ポストされました！"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post.user, notice: "ポストを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice:"ポストを削除しました！"
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    redirect_to new_user_path, alert: "Access denied." unless @post.user == current_user
  end
end
