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
        redirect_to root_path
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
    redirect_to post_path(post.id)  
  end
  
  def destroy
  end
end

 private

  def post_params
    params.require(:post).permit(:title, :image, :body, :is_publish)
  end