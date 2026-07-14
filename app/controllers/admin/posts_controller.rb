class Admin::PostsController < Admin::ApplicationController
  def destroy
    post = Post.find(params[:id]) 
    post.destroy
    redirect_to admin_dashboard_path, notice:"投稿を削除しました"
  end
end
