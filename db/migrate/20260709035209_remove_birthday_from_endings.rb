class RemoveBirthdayFromEndings < ActiveRecord::Migration[8.0]
  def change
    remove_column :endings, :birthday, :date
  end
end
