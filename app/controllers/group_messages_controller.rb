class GroupMessagesController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])

    unless @group.members.exists?(Current.user.id)
      redirect_to group_path(@group), alert: "コミュニティ参加者だけメッセージ投稿できます"
      return
    end

    @message = @group.group_messages.new(group_message_params)
    @message.user = Current.user

    if @message.save
      redirect_to group_path(@group), notice: "メッセージを投稿しました"
    else
      @members = @group.members.with_attached_image
      @messages = @group.group_messages, includes(:user).order(created_at: :asc)

      render "groups/show", status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @message = @group.group_messages.find(params[:id])

    if @message.user == Current.user || @group.owner == Current.user
      @message.destroy
      redirect_to group_path(@group), notice: "メッセージを削除しました"
    else
      redirect_to group_path(@group), alert: "このメッセージは削除できません"
    end
  end

  private

  def group_message_params
    params.require(:group_message).permit(:content)
  end

end
