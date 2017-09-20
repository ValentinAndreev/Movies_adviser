class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :overview
      t.string :poster_path
      t.integer :vote_average
      t.text :genre_ids, array: true, default: []
      t.timestamps  null: false
    end
  end
end
