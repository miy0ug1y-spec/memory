class AddGenreIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :genre, foreign_key: true
  end
end
