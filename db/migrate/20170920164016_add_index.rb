class AddIndex < ActiveRecord::Migration[5.1]
  def change
    add_index(:movies, :title)
  end
end
