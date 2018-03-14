# frozen_string_literal: true

ActiveAdmin.register Review do
  permit_params :text, :user, :movie

  index do
    column :text
    column :user
    column :movie
    actions
  end
end
