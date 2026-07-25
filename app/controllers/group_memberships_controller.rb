class GroupMembershipsController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    Current.user.group_memberships.create(
      group: group
    )

    redirect_to group_path(group), notice: "グループに参加しました"
  end

  def destroy
    group = Group.find(params[:group_id])

    membership = Current.user.group_memberships.find_by(group: group)

    membership&.destroy

    redirect_to group_path(group), notice: "グループから退出しました"
  end


end
