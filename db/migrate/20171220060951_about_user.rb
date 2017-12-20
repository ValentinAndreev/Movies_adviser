class AboutUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :about, :string, default: 'Nothing to say about myself', null: false    
  end
end
