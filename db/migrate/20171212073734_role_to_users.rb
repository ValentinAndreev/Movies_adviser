class RoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string, default: 'user', null: false
    remove_column :users, :is_admin, :boolean
  end
end
