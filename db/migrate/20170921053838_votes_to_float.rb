class VotesToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :vote_average, :float     
  end
end
