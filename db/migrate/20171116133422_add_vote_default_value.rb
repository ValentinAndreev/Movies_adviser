class AddVoteDefaultValue < ActiveRecord::Migration[5.1]
  def change
    change_column :votes, :value, :integer, default: 0, null: false
  end
end
