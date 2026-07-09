class AddBirthdayToEndings < ActiveRecord::Migration[8.0]
  def change
    add_column :endings, :birthday, :date
  end
end
