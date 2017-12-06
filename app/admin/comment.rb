ActiveAdmin.register Comment, as: "UserComment" do
  permit_params :body, :username, :commentable_type, :commentable

  index do
    column :username
    column :body
    column :commentable_type
    column :commentable
    actions
  end
end
