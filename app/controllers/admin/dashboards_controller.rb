class Admin::DashboardsController < Admin::ApplicationController
  def show
    @users = User.all
    @posts = Post.includes(:user).all
    @comments = Comment.includes(:post, :user).order(created_at: :desc).limit(10)

    @users_count = User.count
    @posts_count = Post.count
    @comments_count = Comment.count

    @today_users_count = User.where(created_at: Time.current.all_day).count
    @today_posts_count = Post.where(created_at: Time.current.all_day).count
    @today_comments_count = Comment.where(created_at: Time.current.all_day).count
  end

end
