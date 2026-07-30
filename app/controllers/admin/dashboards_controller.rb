class Admin::DashboardsController < Admin::ApplicationController
  def show
    display_limit = 5

    @users = User.order(created_at: :desc).limit(display_limit)
    @posts = Post.includes(:user).order(created_at: :desc).limit(display_limit)
    @comments = Comment.includes(:post, :user).order(created_at: :desc).limit(display_limit)
    @groups = Group.includes(:owner).order(created_at: :desc).limit(display_limit)
    @endings = Ending.includes(:user).order(created_at: :desc).limit(display_limit)
    

    @users_count = User.count
    @posts_count = Post.count
    @comments_count = Comment.count
    @groups_count = Group.count
    @endings_count = Ending.count

    @today_users_count = User.where(created_at: Time.current.all_day).count
    @today_posts_count = Post.where(created_at: Time.current.all_day).count
    @today_comments_count = Comment.where(created_at: Time.current.all_day).count
    @today_groups_count = Group.where(created_at: Time.current.all_day).count
    @today_endings_count = Ending.where(created_at: Time.current.all_day).count
    
  end

end
