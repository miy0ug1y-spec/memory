class Admin::ApplicationController < ApplicationController::Base
  include Addmin::Authentication
  
  private

  def after_authentication_url
    admin_dashboards_path
  end

  def after_logout_url
    new_admin_session_path
  end
end

