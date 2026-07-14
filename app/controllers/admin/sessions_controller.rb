class Admin::SessionsController < Admin::ApplicationController
  allow_unauthenticated_access only: %i[ new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_admin_session_url, alert:"Try again later."}

  def new
    redirect_to after_authentication_url if authenticated_admin?
  end

  def create
    admin = Admin.authenticate_by(
    email_address: params[:session][:email_address],
    password: params[:session][:password])

    if admin
      start_new_session_for(admin)
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
