class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def mypage
    @user = User.find(Current.user.id)
    @user_image = @user.image 
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @user_image = @user.image 
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to mypage_path(Current.user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
     @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "ユーザー登録が完了しました！続けてログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def withdraw
  end

  private
 
  def user_params
    params.require(:user).permit(:name, :handle_name, :email_address, :password, :password_confirmation, :image)
  end
end
