class Admin::UsersController < Admin::ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    if @user.update(is_active: false)
      @user.sessions.destroy_all
      redirect_to admin_user_path(@user), notice:"ユーザーを退会状態にしました"
    else
      redirect_to admin_user_path(@user), alert: "退会処理に失敗しました"
    end
  end

  def activate
    @user = User.find(params[:id])
    @user.update(is_active: true)

    redirect_to admin_user_path(@user), notice:"ユーザーのステータスを有効状態に戻しました"
  end
end
