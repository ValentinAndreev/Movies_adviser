class TmdbId < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :tmdb_id, :integer
  end    
end
