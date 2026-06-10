class AddGenreIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :genre_id, :integer
  end
end
