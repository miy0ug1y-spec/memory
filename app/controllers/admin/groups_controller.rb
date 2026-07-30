class Admin::GroupsController < Admin::ApplicationController

  def index
    @groups = Group.includes(:owner).order(created_at: :asc)
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to admin_groups_path, notice:"コミュニティを削除しました"
  end

end
