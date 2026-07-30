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
    

    chart_range = 29.days.ago.to_date..Date.current

    @activity_chart = [
      {
        name: "ユーザー登録数",
        data: User.group_by_day(:created_at, range: chart_range, format: "%m/%d").count
      },
      {
        name: "投稿数",
        data: Post.group_by_day(:created_at, range: chart_range, format: "%m/%d").count
      }
    ]

    @posts_by_genre = Genre.left_joins(:posts).group("genres.name").count("posts.id")

    group_member_counts = Group.includes(:group_memberships).map do |group|
      [group.name, group.group_memberships.count(&:approved?)]
    end

    @group_member_counts = group_member_counts.sort_by { |_name, count| -count }.first(5).to_h
  end

end
