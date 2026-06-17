class PostsController < ApplicationController
  allow_unauthenticated_access only: [:index]
  def index
    @posts = Post.published 
  end

  def show
    @post = Post.find(params[:id])  
  end

  def mypost
     @posts = Current.user.posts
  end
  
  def new
    @post = Post.new
  end
  
  
  def create
    @post = Post.new(post_params)
    @post.user_id = Current.user.id

    if @post.save
      if @post.is_publish?
        redirect_to root_path, notice:"投稿が成功しました。"
      else
        redirect_to mypost_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id), notice:"投稿の編集が成功しました。" 
  end
  
  def destroy
    post = Post.find(params[:id]) 
    post.destroy
    redirect_to mypost_path, notice:"削除しました。"
  end

end

 private

  def post_params
    params.require(:post).permit(:title, :image, :body, :is_publish)
  end