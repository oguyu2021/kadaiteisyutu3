class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :show, :update]
  
  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id) 
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    # binding.irb
    @user = User.find(params[:id])
    if @user = current_user
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: "プロフィールを編集しました！"
     else
       render :edit
     end      
    else
      redirect_to user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      edirect_to pictures_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
