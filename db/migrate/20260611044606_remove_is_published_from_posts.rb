class RemoveIsPublishedFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :is_publish, :boolean
  end
end
