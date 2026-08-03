class Admin::PostsController < Admin::ApplicationController

  def index
    @posts = Post.includes(:user, :genre).order(created_at: :asc).page(params[:page]).per(10) 
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id]) 
    post.destroy
    redirect_to admin_dashboard_path, notice:"投稿を削除しました"
  end
end
