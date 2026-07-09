class EndingsController < ApplicationController
  def new
    if Current.user.ending
      redirect_to ending_path(Current.user.ending)
    else
      @ending = Ending.new
      @user = Current.user
      @posts = Current.user.posts
    end
  end

  def edit
    @ending = Ending.find(params[:id])
    return redirect_to root_path unless @ending.user == Current.user
  end

  def create
    @ending = Ending.new(ending_params)
    @ending.user_id = Current.user.id
    @ending.birthday = Current.user.birthday
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
  end

  def destroy
  end


private

  def ending_params
    params.require(:ending).permit(
  :post_id,
  :episode,
  :feeling,
  :images []
  )
  end

end

