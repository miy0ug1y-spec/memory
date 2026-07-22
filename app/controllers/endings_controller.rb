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

  def download
    @ending = Current.user.ending

    if @ending.nil? ||@ending.id != params[:id].to_i
      redirect_to root_path, alert:"ダウンロードできません"
      return
    end

    pdf = Prawn::Document.new

    font_path = Rails.root.join(
      "app/assets/fonts/NotoSansJP-Regular.ttf"
    )

    pdf.font_families.update(
      "JapaneseFont" => {
        normal: font_path.to_s
      }
    )

    pdf.font "JapaneseFont"

    pdf.text "MyEnding", size: 24
    pdf.move_down 20

    pdf.text "氏名"
    pdf.text "#{@ending.user.last_name} #{@ending.user.first_name}"

    pdf.move_down 15

    pdf.text "生年月日"
    pdf.text (
      @ending.user.birthday&.strftime("%Y年%m月%d日") || "未設定"
    )

    pdf.move_down 15

    pdf.text "大切な人に伝えたいことや感謝の気持ち"
    pdf.text @ending.feeling.to_s

    pdf.move_down 15

    pdf.text "エピソード　ー忘れられない記憶や懐かしい思い出ー"
    pdf.text @ending.episode.to_s

    send_data pdf.render,
      filename: "my_ending.pdf",
      type: "application/pdf",
      disposition: "attachment"  
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

