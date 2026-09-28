class CreateAiMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_messages do |t|
      t.references :ai_chat, null: false, type: :integer, foreign_key: true
      t.string :role
      t.text :content
      t.timestamps
    end
  end
end
