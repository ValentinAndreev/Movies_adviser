class AddImbdId < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :imbd_id, :string
  end
end
