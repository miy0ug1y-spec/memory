class GroupsController < ApplicationController
  
  def index
    @groups = Group.includes(:owner, :members).order(created_at: :desc).page(params[:page]).per(5)  
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members.with_attached_image

    @current_membership = @group.group_memberships.find_by(user: Current.user)
    if @group.owner == Current.user
      @pending_memberships = @group.group_memberships.pending.includes(:user)
    end

    @messages = @group.group_messages.includes(user: {image_attachment: :blob}).order(created_at: :asc)
    @message = GroupMessage.new
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Current.user.owned_groups.new(group_params)

    if @group.save
      @group.group_memberships.create!(
        user: Current.user,
        status: :approved
      )



      redirect_to group_path(@group), notice: "コミュニティを作成しました"
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
      redirect_to group_path(@group), notice: "コミュニティを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Current.user.owned_groups.find(params[:id])
    @group.destroy

    redirect_to groups_path, notice: "コミュニティを削除しました"
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
