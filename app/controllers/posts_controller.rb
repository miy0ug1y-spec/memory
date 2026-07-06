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
        redirect_to mypage_path, notice:"投稿が成功しました。"
      else
        redirect_to mypost_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    return redirect_to root_path unless @post.user == Current.user
  end
  
  def update
   @post = Post.find(params[:id])
   return redirect_to root_path unless @post.user == Current.user 

    if params[:remove_image] == "1"
      @post.image.purge
    end

    if @post.update(post_params)
      if @post.is_publish?
        redirect_to mypage_path, notice:"編集が成功しました。"
      else
        redirect_to mypost_path, notice:"編集が成功しました。"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    post = Post.find(params[:id]) 
    return redirect_to root_path unless post.user == Current.user

    post.destroy
    redirect_to mypost_path, notice:"削除しました。"
  end

end

 private

  def post_params
    params.require(:post).permit(:title, :image, :body, :is_publish)
  end