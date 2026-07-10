class EndingsController < ApplicationController
  def new
    if Current.user.ending
      redirect_to ending_path(Current.user.ending)
    else
      @ending = Ending.new
      @user = Current.user
      @posts = Current.user.posts.with_attached_image
    end
  end

  def edit
    @ending = Current.user.ending
    unless @ending
      redirect_to new_ending_path
    return
    end
    @posts = Current.user.posts.with_attached_image
  end

  def create
    @ending = Ending.new(ending_params)
    @ending.user_id = Current.user.id
    if @ending.save
      redirect_to ending_path(@ending)
    else
      @posts = Current.user.posts
      Rails.logger.debug "保存失敗: #{@ending.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end
 
  def show
    @ending = Ending.find(params[:id])
  end

  def update
    @ending = Current.user.ending
    
    unless @ending
      redirect_to new_ending_path
    return
    end
    if @ending.update(ending_params)
      redirect_to ending_path(@ending), notice: "更新しました"
    else
      @posts = Current.user.posts
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ending = Current.user.ending
    if @ending
      @ending.destroy
    end
    redirect_to new_ending_path, notice: "削除しました"
  end


private

  def ending_params
    params.require(:ending).permit(
  :episode,
  :feeling,
  :image,
  post_ids: []
  )
  end

end

