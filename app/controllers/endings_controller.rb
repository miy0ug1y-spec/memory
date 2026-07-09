class EndingsController < ApplicationController
  def new
    @ending = Ending.new
    @user = Current.user
    @posts =Current.user.posts
  end

  def edit
  end

  def create
    @ending = Ending.new(ending_params)
    @ending.user_id = Current.user.id
    if @ending.save
      redirect_to edit_endings_path(@ending)
    else
      Rails.logger.debug "保存失敗: #{@ending.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
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
  :image
  )
  end

end

