class RemoveGenresIds < ActiveRecord::Migration[5.1]
  def change
    remove_column :movies, :genre_ids, array: true, default: []     
  end
end
