class PostsController < ApplicationController
  allow_unauthenticated_access only: [:index]
  def index
    @posts = Post.published
  end

  def show
  
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = Current.user.id
    @post.save
    redirect_to post_path(Current.user)
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end

 private

  def post_params
    params.require(:post).permit(:title, :image, :body, :is_publish)
  end