class PostsController < ApplicationController
  allow_unauthenticated_access only: [:index]
  def index
    @posts = Post.published.includes(:user, :genre).order(created_at: :desc)
    @genres = Genre.all

    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @posts = @posts.where(genre_id: @genre.id)
    end
  end

  def show
    @post = Post.find(params[:id]) 
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :asc)

    if @comment.save
      redirect_to post_path(@post), notice:"コメントしました"
    else
      render "posts/show", status: :unprocessable_entity
    end
  end

  def mypost
     @posts = Current.user.posts.where(is_publish: false)
  end
  
  def new
    @post = Post.new
    @genres = Genre.all
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
    @genres = Genre.all
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
    params.require(:post).permit(:title, :image, :body, :is_publish, :genre_id)
  end