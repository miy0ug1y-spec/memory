class GroupsController < ApplicationController
  
  def index
    @groups = Group.includes(:owner).order(created_at: :desc)  
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members.with_attached_image

    @messages = @group.group_messages.includes(user: {image_attachment: :blob}).order(created_at: :asc)
    @message = GroupMessage.new
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Current.user.owned_groups.new(group_params)

    if @group.save
      @group.group_memberships.create(user: Current.user)

      redirect_to group_path(@group), notice: "グループを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @group = Current.user.owned_groups.find(params[:id])
  end

  def update
    @group = Current.user.owned_groups.find(params[:id])

    if params[:remove_image] == 1
      @group.image.purge
    end

    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Current.user.owned_groups.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :introduction,
      :image
    )
  end
  
end
