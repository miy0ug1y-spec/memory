class Admin::ApplicationController < ActionController::Base
  layout 'admin'
  include Admin::Authentication
  
  private

  def after_authentication_url
    admin_dashboard_path
  end

  def after_logout_url
    new_admin_session_path
  end
end

