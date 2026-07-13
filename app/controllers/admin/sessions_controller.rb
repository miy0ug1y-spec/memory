class Admin::SessionsController < Admin::ApplicationController
  allow_unauthenticated_access only : %![ new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_admin_session_url, alert:"Try again later."}

  def new
    redirect_to after_authentication_url if authenticated_admin?
  end

  def create
    if admin = Admin.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for admin
      redirect_to after_authentication_url
    else
      redirect_to new_admin_session_path, alert:"メールアドレスまたはパスワードが正しくありません"
    end
  end

  def destroy
    terminate_session
    redirect_to after_logout_url
  end
end
