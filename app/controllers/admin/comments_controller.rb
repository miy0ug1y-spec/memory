class Admin::CommentsController < Admin::ApplicationController

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_dashboard_path, notice:"コメントを削除しました"
  end

end
