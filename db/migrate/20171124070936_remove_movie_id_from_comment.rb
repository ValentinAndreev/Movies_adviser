class RemoveMovieIdFromComment < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :movie_id
  end
end
