class Admin::PostsController < Admin::ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id]) 
    post.destroy
    redirect_to admin_dashboard_path, notice:"投稿を削除しました"
  end
end
