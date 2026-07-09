class CreateEndings < ActiveRecord::Migration[8.0]
  def change
    create_table :endings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :feeling
      t.text :episode

      t.timestamps
    end
  end
end
