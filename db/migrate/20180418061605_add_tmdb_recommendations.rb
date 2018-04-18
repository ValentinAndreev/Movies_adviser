class AddTmdbRecommendations < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :recommendations, :integer, array: true, default: []
  end
end
