class GroupMembershipsController < ApplicationController
  before_action :set_group
  before_action :ensure_owner, only: [:approve, :reject]

  def create
    membership = Current.user.group_memberships.find_or_initialize_by(group: @group)

    membership.status = :pending

    if membership.save
      redirect_to group_path(@group), notice: "参加申請をしました"
    else
      redirect_to group_path(@group), alert: "参加申請に失敗しました"
    end
  end

  def destroy
    membership = Current.user.group_memberships.find_by(group: @group)

    membership&.destroy

    redirect_to group_path(@group), notice: "参加申請または参加を取り消しました"
  end

  def approve
    membership = @group.group_memberships.find(params[:id])
    membership.update(status: :approved)

    redirect_to group_path(@group), notice:"参加申請を承認しました"
  end

  def reject
    membership = @group.group_memberships.find(params[:id])
    membership.update(status: :rejected)

    redirect_to group_path(@group), notice: "参加申請を非承認にしました"
  end

  private 

  def set_group
    @group = Group.find(params[:group_id])
  end

  def ensure_owner
    unless @group.owner == Current.user
    
    redirect_to group_path(@group), alert: "この操作を行う権限がありません"
    end
  end

end
