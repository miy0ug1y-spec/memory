class ChangePostIdNullOnEndings < ActiveRecord::Migration[8.0]
  def change
    change_column_null :endings, :post_id, true
  end
end
