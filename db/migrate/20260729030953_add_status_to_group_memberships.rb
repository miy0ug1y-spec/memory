class AddStatusToGroupMemberships < ActiveRecord::Migration[8.0]
  def change
    add_column :group_memberships, :status, :integer, null: false, default: 0
  end
end
