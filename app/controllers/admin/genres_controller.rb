class Admin::GenresController < Admin::ApplicationController
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
 
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice:"ジャンルを追加しました"
    else
      @genres = Ganre.all
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update
      redirect_to admin_genre_path, notice:"ジャンルを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genre_path, notice:"ジャンルを削除しました"
  end

private

  def genre_params
    params.require(:genre).permit(:name)
  end


end
