class Admin::DashboardsController < Admin::ApplicationController
  def index
    @users = User.all
  end
end
