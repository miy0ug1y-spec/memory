class Admin::UsersController < Admin::ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)

    redirect_to admin_user_path(@user), notice:"ユーザーを退会状態にしました"
  end

  def activate
    @user = User.find(params[:id])
    @user.update(is_active: true)

    redirect_to admin_user_path(@user), notice:"ユーザーのステータスを有効状態に戻しました"
  end
end
