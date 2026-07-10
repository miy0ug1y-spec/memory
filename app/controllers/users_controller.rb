class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def mypage
    @posts = Post.published
    @user = User.find(Current.user.id)
    if @user != Current.user
      redirect_to root_path
    end
    @user_image = @user.image 
  end

  def edit
    @user = User.find(params[:id])
    if @user != Current.user
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @user_image = @user.image 
  end

  def update
    @user = User.find(params[:id])
    return redirect_to(root_path) unless @user == Current.user
    if @user.update(user_params)
      redirect_to mypage_path,notice: "ユーザー情報の編集が完了しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
     @user = User.new(user_params)
    if @user.save
      redirect_to mypage_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def withdraw
    @user = User.find(params[:id])
    return redirect_to root_path unless @user == Current.user

    @user.update!(is_active: false)

    Current.session.destroy
    redirect_to new_user_path, notice: "退会しました。"
  end

  private
 
  def user_params
    params.require(:user).permit(
      :last_name,
      :first_name, 
      :handle_name, 
      :email_address,
      :birthday, 
      :password, 
      :password_confirmation, 
      :image,
      :introduction
      )
  end
end
