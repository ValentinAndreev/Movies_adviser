FactoryGirl.define do
  factory :movie do
    title 'The Shawshank Redemption'
    overview 'Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne...'
    vote_average 9.3
    genres ["Drama", "Crime"]
    imbd_id "tt0111161"
    tmdb_id 278
    release_date "1994-09-23"
    poster_path '/path'
  end
end