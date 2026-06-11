class PostsController < ApplicationController
  allow_unauthenticated_access only: [:index]
  def index
    @posts = Post.all
  end

  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
