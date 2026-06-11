class AddIsPublishToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :is_publish, :boolean
  end
end
