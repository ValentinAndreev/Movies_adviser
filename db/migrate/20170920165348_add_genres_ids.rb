class AddGenresIds < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :genre_ids, :integer, array: true, default: []
  end
end
