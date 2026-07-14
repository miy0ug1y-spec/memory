class Admin::DashboardsController < Admin::ApplicationController
  def show
    @users = User.all
    @posts = Post.all
  end

end
