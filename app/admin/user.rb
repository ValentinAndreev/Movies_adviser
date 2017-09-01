ActiveAdmin.register User do
  permit_params :username, :email, :avatar, :password, :password_confirmation, :is_admin
  
  index do
    column :username
    column :email
    column :is_admin
    actions
  end

  form do |f|
    f.inputs 'User' do
      f.input :username
      f.input :email
      f.input :is_admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
