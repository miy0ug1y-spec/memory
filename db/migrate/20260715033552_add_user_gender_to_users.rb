class AddUserGenderToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :gender, :integer,default: 0, null: false
  end
end
