class CreateAiChats < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_chats do |t|
      t.references :user, null: false, type: :integer, foreign_key: true
      t.string :title
      t.timestamps
    end
  end
end
