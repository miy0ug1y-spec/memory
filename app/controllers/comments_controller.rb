class CommentsController < ApplicationController
 
  def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.new(comment_params)
   @comment.user = Current.user
    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました"
    else
      @comments = @post.comments.includes(:user).order(created_at: :desc)
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    unless Current.user == @comment.user
      redirect_to post_path(@post), alart:"このコメントは削除できません"
      return
    end
    @comment.destroy
    redirect_to post_path(@post), notice: "コメントを削除しました" 
  end
end

private
 def comment_params
  params.require(:comment).permit(:content)
 end