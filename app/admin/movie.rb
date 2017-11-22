ActiveAdmin.register Movie do
  permit_params :title, :overview, :vote_average, :imbd_id, :tmdb_id, :release_date, :genres

  index do
    column :title
    column :overview
    column :vote_average
    column :imbd_id
    column :tmdb_id
    column :release_date
    column :genres
    actions
  end
end
